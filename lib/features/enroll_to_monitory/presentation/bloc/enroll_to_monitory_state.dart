part of 'enroll_to_monitory_bloc.dart';

abstract class EnrollToMonitoryState extends Equatable {
  const EnrollToMonitoryState();

  @override
  List<Object> get props => [];
}

class EnrollToMonitoryInitial extends EnrollToMonitoryState {}

class LoadingState extends EnrollToMonitoryState {}

class MateriasRetrieved extends EnrollToMonitoryState {
  final List<CustomMateria> materias;

  const MateriasRetrieved({
    required this.materias,
  });

  @override
  List<Object> get props => [materias];
}

class MonitoresRetrieved extends EnrollToMonitoryState {
  final List<Monitor> monitores;

  const MonitoresRetrieved({
    required this.monitores,
  });

  @override
  List<Object> get props => [];
}

class MonitoriesRetrieved extends EnrollToMonitoryState {
  final List<AvailableMonitory> monitories;

  const MonitoriesRetrieved({required this.monitories});
  @override
  List<Object> get props => [];
}

class EnrolledStudentState extends EnrollToMonitoryState {}

class ErrorState extends EnrollToMonitoryState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
