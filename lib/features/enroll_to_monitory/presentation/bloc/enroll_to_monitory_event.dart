part of 'enroll_to_monitory_bloc.dart';

abstract class EnrollToMonitoryEvent extends Equatable {
  const EnrollToMonitoryEvent();

  @override
  List<Object> get props => [];
}

class InitialPageEvent extends EnrollToMonitoryEvent {}

class DoMateriaSelectedEvent extends EnrollToMonitoryEvent {
  final CustomMateria materia;

  const DoMateriaSelectedEvent({required this.materia});

  @override
  List<Object> get props => [materia];
}

class DoSearchEvent extends EnrollToMonitoryEvent {
  final CustomMateria materia;
  final Monitor? monitor;

  const DoSearchEvent({
    required this.materia,
    this.monitor,
  });
}

class DoEnrollEvent extends EnrollToMonitoryEvent {
  final String codMonitory;

  const DoEnrollEvent({
    required this.codMonitory,
  });

  @override
  List<Object> get props => [codMonitory];
}
