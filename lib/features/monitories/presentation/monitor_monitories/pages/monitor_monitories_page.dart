import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/core/widgets/object_dropdown.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/core/widgets/rounded_button.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitories/presentation/monitor_monitories/bloc/monitor_monitories_bloc.dart';
import 'package:app_sostegno/features/monitories/presentation/monitor_monitories/widgets/my_monitory_card.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class MonitorMonitoriesPage extends StatefulWidget {
  const MonitorMonitoriesPage({Key? key}) : super(key: key);

  @override
  State<MonitorMonitoriesPage> createState() => _MonitorMonitoriesPageState();
}

class _MonitorMonitoriesPageState extends State<MonitorMonitoriesPage> {
  int? _materiaSelected;

  List<MonitorMonitoria> _monitorMaterias = [];
  List<AvailableMonitory> _monitorMonitories = [];

  @override
  void initState() {
    final bloc = context.read<MonitorMonitoriesBloc>();
    bloc.add(const InitialPageEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGrayBackgroundColor,
        body: Column(
          children: [
            PurpleHeader(
              onPressed: () {
                Get.back();
              },
              icon: Icons.arrow_back,
              title: 'Mis Monitorias',
            ),
            BlocConsumer<MonitorMonitoriesBloc, MonitorMonitoriesState>(
              listener: (context, state) {
                if (state is InitialDataRetrieved) {
                  _monitorMonitories = state.monitories;
                  _monitorMaterias = state.materias;
                } else if (state is MonitoriesByMateriaRetrieved) {
                  setState(() {
                    _monitorMonitories = state.monitories;
                  });
                } else if (state is MonitoriesError) {
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
                if (state is LoadingMonitoriesState) {
                  return Center(
                    child: Image.asset(
                      'assets/gifs/studying_lila.gif',
                      height: 300,
                      width: 300,
                    ),
                  );
                } else if (state is MonitoriesError) {
                  return const SizedBox();
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ObjectDropdown(
                                actualValue: _materiaSelected,
                                borderColor: kDarkBlue,
                                width: 180,
                                hintText: 'Seleccione Materia',
                                itemList: _monitorMaterias,
                                onChanged: (val) {
                                  setState(() {
                                    _materiaSelected = val;
                                  });
                                },
                              ),
                              RoundedButton(
                                backColor: kDarkBlue,
                                onPressed: () {
                                  context.read<MonitorMonitoriesBloc>().add(
                                      DoMateriaSelectedEvent(
                                          codMateria: _materiaSelected!));
                                },
                                text: 'Buscar',
                                minWidth: 100,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _monitorMonitories.length,
                            itemBuilder: (context, index) {
                              return MonitoryCard(
                                monitory: _monitorMonitories[index],
                                verButton: () {
                                  Get.toNamed(RoutesName.MONITORY_DETAILS,
                                      arguments: {
                                        'monitorySelected':
                                            _monitorMonitories[index],
                                      });
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
