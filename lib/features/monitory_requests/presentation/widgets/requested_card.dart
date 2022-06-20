import 'package:flutter/material.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/widgets/text_icon_button.dart';

class RequestedCard extends StatelessWidget {
  const RequestedCard({
    Key? key,
    required this.nombreMateria,
    required this.diaExacto,
    required this.horaInicio,
    required this.horaFin,
    this.aceptarButton,
    this.rechazarButton,
  }) : super(key: key);

  final String nombreMateria;
  final String diaExacto;
  final String horaInicio;
  final String horaFin;
  final VoidCallback? aceptarButton;
  final VoidCallback? rechazarButton;

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
          height: 220,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                color: Colors.black54.withOpacity(0.1),
                offset: const Offset(0.0, 2.0),
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Solicitud de monitoria',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
              const SizedBox(height: 5),
              Text(
                'Materia: ${nombreMateria.toUpperCase()}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    'El día:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    diaExacto,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: kMainPinkColor),
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    'En horario:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Builder(builder: (context) {
                    final initHour =
                        '${horaInicio.split(':')[0]}:${horaInicio.split(':')[1]}';
                    final finalHour =
                        '${horaFin.split(':')[0]}:${horaFin.split(':')[1]}';
                    return Text(
                      '$initHour - $finalHour h',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: kMainPinkColor),
                    );
                  })
                ],
              ),
              const SizedBox(height: 15),
              TextIconButton(
                icon: Icons.check,
                text: 'Aceptar',
                width: 120,
                onTap: aceptarButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
