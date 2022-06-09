import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/text_icon_button.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitories/presentation/monitory_details/bloc/monitory_details_bloc.dart';
import 'package:app_sostegno/routes/routes_name.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MonitoryDetailsView extends StatefulWidget {
  const MonitoryDetailsView({
    Key? key,
    required this.monitorySelected,
    required this.personType,
  }) : super(key: key);
  final AvailableMonitory monitorySelected;
  final int personType;
  @override
  State<MonitoryDetailsView> createState() => _MonitoryDetailsViewState();
}

List days = [
  'Domingo',
  'Lunes',
  'Martes',
  'Miercoles',
  'Jueves',
  'Viernes',
  'Sabado'
];

class _MonitoryDetailsViewState extends State<MonitoryDetailsView> {
  AvailableMonitory? _monitory;

  @override
  void initState() {
    _monitory = widget.monitorySelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: kDarkBlue,
        letterSpacing: 0.2,
        fontSize: 18,
      ),
      child: BlocConsumer<MonitoryDetailsBloc, MonitoryDetailsState>(
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
          if (state is CanceledMonitory) {
            messageDialog(
              context,
              title: "Monitoria eliminada exitosamente",
              msg: "Volver a inicio",
              action: () => Get.offAllNamed(RoutesName.My_CALENDAR),
            );
          }
        },
        builder: (context, state) {
          final Uri toLaunch = Uri.parse(_monitory!.detalles);
          if (state is LoadingState) {
            return Center(
              child: Image.asset(
                'assets/gifs/studying_lila.gif',
                height: 300,
                width: 300,
              ),
            );
          } else {
            final month = DateFormat("MMMM", 'Es_co')
                .format(_monitory!.fecha)
                .toUpperCase();
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: kDarkBlue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            ' ${_monitory!.fecha.toIso8601String().split('-')[2].split('T')[0]}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        month,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Text(
                        '${days[_monitory!.fecha.weekday]}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Builder(builder: (context) {
                        final horaInicio = _monitory!.fecha
                            .toIso8601String()
                            .split('T')[1]
                            .substring(0, 5);
                        final horaFin = _monitory!.fin.substring(0, 5);
                        return Text(
                          '$horaInicio - $horaFin',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: kMainPinkColor,
                          ),
                        );
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Monitoría de ${_monitory!.monitorMonitoria.materia.nombre}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child: Text(
                      'Monitor ${_monitory!.monitorMonitoria.monitor!.user.firstName} ${_monitory!.monitorMonitoria.monitor!.user.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(RoutesName.MONITOR_DETAILS, arguments: {
                        'codMonitor': '${_monitory!.monitorMonitoria.id}',
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Modalidad: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _monitory!.modalidad == '0' ? 'Virtual' : 'Presencial',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: kMainPinkColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Enlace: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_monitory!.modalidad == '0') {
                        setState(() {
                          _launchInBrowser(toLaunch);
                        });
                      }
                    },
                    child: Text(
                      _monitory!.detalles,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kMainPinkColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 45.0,
                  ),
                  widget.personType == 0
                      ? TextIconButton(
                          text: 'Cancelar',
                          icon: Icons.restore_from_trash,
                          width: 120.0,
                          onTap: () {
                            context.read<MonitoryDetailsBloc>().add(
                                  CancelMonitoryEvent(
                                    codMonitory: '${_monitory!.id}',
                                  ),
                                );
                          },
                        )
                      : const SizedBox()
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
