import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/features/monitory_requests/presentation/bloc/monitory_requests_bloc.dart';
import 'package:app_sostegno/features/monitory_requests/presentation/widgets/requested_card.dart';
import 'package:app_sostegno/injection_container.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class RequestedMonitoriesPage extends StatefulWidget {
  const RequestedMonitoriesPage({Key? key}) : super(key: key);

  @override
  State<RequestedMonitoriesPage> createState() =>
      _RequestedMonitoriesPageState();
}

class _RequestedMonitoriesPageState extends State<RequestedMonitoriesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MonitoryRequestsBloc>()..add(InitialPageEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kGrayBackgroundColor,
          body: Column(
            children: [
              PurpleHeader(
                onPressed: () {
                  Get.back();
                },
                icon: Icons.arrow_back,
                title: 'Solicitudes de monitoría',
              ),
              Expanded(
                child:
                    BlocConsumer<MonitoryRequestsBloc, MonitoryRequestsState>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      errorDialog(
                        context,
                        title: 'Error Inesperado',
                        msg: 'Ha ocurrido un error, por favor intente de nuevo',
                        action: () {
                          Get.offNamedUntil(
                            RoutesName.My_CALENDAR,
                            (route) => false,
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RequestsRetrieved) {
                      final requests = state.requests;
                      return ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final request = requests[index];
                          return RequestedCard(
                            diaExacto:
                                request.fecha.toIso8601String().split('T')[0],
                            horaInicio:
                                request.fecha.toIso8601String().split('T')[1],
                            horaFin: request.fin,
                            nombreMateria: request.materia.nombre,
                            aceptarButton: () {
                              Get.toNamed(RoutesName.CREATE_MONITORY,
                                  arguments: {
                                    'hasPreData': true,
                                    'requestData': request,
                                  });
                            },
                          );
                        },
                      );
                    } else if (state is LoadingState) {
                      return Center(
                        child: Image.asset('assets/gifs/studying.gif'),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
