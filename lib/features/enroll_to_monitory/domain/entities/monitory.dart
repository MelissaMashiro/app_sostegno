import 'package:equatable/equatable.dart';

class Monitory extends Equatable {
  final String codigo;
  final String dia;
  final String horaInicio;
  final String horaFin;
  final String materia;
  final String monitor;
  final String codmonitor;
  final String modality;
  final String? enlace;
  final String? salon;

  const Monitory({
    required this.codigo,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
    required this.materia,
    required this.monitor,
    required this.codmonitor,
    required this.modality,
    this.enlace,
    this.salon,
  });

  @override
  List<Object?> get props => [codigo];
}
