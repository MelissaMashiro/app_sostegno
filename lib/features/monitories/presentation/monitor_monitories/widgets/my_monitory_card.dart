import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/text_icon_button.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:intl/intl.dart';

List days = [
  'Lunes',
  'Martes',
  'Miercoles',
  'Jueves',
  'Viernes',
  'Sabado',
  'Domingo',
];

class MonitoryCard extends StatelessWidget {
  const MonitoryCard({
    Key? key,
    this.verButton,
    required this.monitory,
  }) : super(key: key);

  final AvailableMonitory monitory;
  final VoidCallback? verButton;

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
          height: 210,
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
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                final month = DateFormat("MMMM", 'Es_co')
                    .format(monitory.fecha)
                    .toUpperCase();
                final day = monitory.fecha
                    .toIso8601String()
                    .split('-')[2]
                    .split('T')[0];
                return Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: kDarkBlue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
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
                          fontWeight: FontWeight.w700, fontSize: 19),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 15),
              Builder(builder: (context) {
                final horaInicio = monitory.fecha
                    .toIso8601String()
                    .split('T')[1]
                    .substring(0, 5);
                final horaFin = monitory.fin.substring(0, 5);
                return Row(
                  children: [
                    Text(
                      '${days[monitory.fecha.weekday - 1]}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$horaInicio - $horaFin',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: kMainPinkColor),
                    )
                  ],
                );
              }),
              Text(
                'Monitoría de  ${monitory.monitorMonitoria.materia.nombre}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              TextIconButton(
                icon: Icons.forward,
                text: 'Ver',
                onTap: verButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
