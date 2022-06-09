import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/monitor_details/presentation/bloc/monitor_details_bloc.dart';
import 'package:app_sostegno/routes/routes_name.dart';

class MonitorDetailsView extends StatefulWidget {
  const MonitorDetailsView({
    Key? key,
  }) : super(key: key);
  @override
  State<MonitorDetailsView> createState() => _MonitorDetailsViewState();
}

class _MonitorDetailsViewState extends State<MonitorDetailsView> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return BlocConsumer<MonitorDetailsBloc, MonitorDetailsState>(
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
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MonitorDetailsRetrieved) {
          final monitor = state.monitor;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Text(
                      '${monitor.user.firstName} ${monitor.user.lastName}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Universidad ${monitor.user.entidad!.nombre}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: mq.width * 0.90,
                      height: mq.height / 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0.0, 2.0), //(x,y)
                            blurRadius: 7.5,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            monitor.descripcion,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 1,
                            thickness: 0.8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Semestre',
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${monitor.monitoriasCount}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Monitorias\nrealizadas')
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Materias',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children:
                                  monitor.porcentajes.map<Widget>((item) {
                                return MateriaPercentWidget(
                                  porcentaje: item,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class MateriaPercentWidget extends StatelessWidget {
  const MateriaPercentWidget({
    Key? key,
    required this.porcentaje,
  }) : super(key: key);
  final MonitorMonitoria porcentaje;
  @override
  Widget build(BuildContext context) {
    print('RESULTADO=>${180 - (porcentaje.porcentaje).toDouble()}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(porcentaje.materia.nombre),
          ),
          const SizedBox(
            width: 40,
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                height: 20,
                width: 180,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: kMainPurpleColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 1,
                      color: kMainPurpleColor,
                    ),
                  ),
                  height: 20,
                  width: 180
                  //  width: 180 - (porcentaje.porcentaje).toDouble(),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
