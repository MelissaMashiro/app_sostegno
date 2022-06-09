import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/features/enroll_to_monitory/presentation/bloc/enroll_to_monitory_bloc.dart';
import 'package:app_sostegno/features/enroll_to_monitory/presentation/widgets/available_monitory_card.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class EnrollStep2Page extends StatefulWidget {
  const EnrollStep2Page({Key? key}) : super(key: key);

  @override
  State<EnrollStep2Page> createState() => _EnrollStep2PageState();
}

class _EnrollStep2PageState extends State<EnrollStep2Page> {
  final EnrollToMonitoryBloc enrollToMonitoryBloc =
      Get.arguments['enrollToMonitoryBloc'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGrayBackgroundColor,
        body: Column(
          children: [
            PurpleHeader(
              title: 'Incribirme a Monitoria',
              icon: Icons.arrow_back,
              onPressed: () {
                Get.back();
              },
            ),
            Expanded(
              child: BlocProvider.value(
                value: enrollToMonitoryBloc,
                child:
                    BlocConsumer<EnrollToMonitoryBloc, EnrollToMonitoryState>(
                  listener: (context, state) {
                    if (state is EnrolledStudentState) {
                      messageDialog(
                        context,
                        title: 'Operación Exitosa!',
                        msg: 'Inscripcion a monitoria realizada.',
                        action: () {
                          Get.offNamedUntil(
                            RoutesName.My_CALENDAR,
                            (route) => false,
                          );
                        },
                      );
                    }
                    if (state is ErrorState) {
                      errorDialog(
                        context,
                        title: 'Suscripción Exitosa',
                        msg: 'Click para volver al Calendario principal',
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
                    if (state is MonitoriesRetrieved) {
                      return ListView.builder(
                        itemCount: state.monitories.length,
                        itemBuilder: (context, index) {
                          return AvailableMonitoryCard(
                            monitory: state.monitories[index],
                            enrollButton: () {
                              //!TODO: COLOCAR UN DIALOGO QUE PREGUNTE Y AL UNDIR SI, SE MANDA EL EVENTO
                              context.read<EnrollToMonitoryBloc>().add(
                                    DoEnrollEvent(
                                      codMonitory:
                                          '${state.monitories[index].id}',
                                    ),
                                  );
                            },
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
