import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/text_icon_button.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:intl/intl.dart';

List days = [
  'Domingo',
  'Lunes',
  'Martes',
  'Miercoles',
  'Jueves',
  'Viernes',
  'Sabado'
];

class MyCalendarCard extends StatelessWidget {
  const MyCalendarCard({
    Key? key,
    this.onVerTap,
    required this.monitory,
  }) : super(key: key);
  final AvailableMonitory monitory;
  final VoidCallback? onVerTap;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: kDarkBlue,
        letterSpacing: 0.2,
        fontSize: 17,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 10,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 15.0,
          ),
          height: 258,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                color: Colors.black54.withOpacity(0.05),
                offset: const Offset(0.0, 2.0), //(x,y)
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                final month = DateFormat("MMMM", 'Es_co')
                    .format(monitory.fecha)
                    .toUpperCase();
                return Text(
                  ' ${monitory.fecha.toIso8601String().split('-')[2].split('T')[0]} $month',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                );
              }),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    '${days[monitory.fecha.weekday]}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Builder(builder: (context) {
                    final horaInicio = monitory.fecha
                        .toIso8601String()
                        .split('T')[1]
                        .substring(0, 5);
                    final horaFin = monitory.fin.substring(0, 5);
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
              Text(
                'Monitoría de ${monitory.monitorMonitoria.materia.nombre}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Monitor ${monitory.monitorMonitoria.monitor!.user.firstName} ${monitory.monitorMonitoria.monitor!.user.lastName}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
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
                    monitory.modalidad == '0' ? 'Virtual' : 'Presencial',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kMainPinkColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextIconButton(
                icon: Icons.forward,
                text: 'Ver',
                onTap: onVerTap,
              )
            ],
          ),
        ),
      ),
    );
  }
}
