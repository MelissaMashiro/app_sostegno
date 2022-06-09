part of 'monitory_creation_bloc.dart';

abstract class MonitoryCreationState extends Equatable {
  const MonitoryCreationState();

  @override
  List<Object> get props => [];
}

class MonitoryCreationInitial extends MonitoryCreationState {}

class MateriasRetrieved extends MonitoryCreationState {
  final List<MonitorMonitoria> materias;

  const MateriasRetrieved({
    required this.materias,
  });

  @override
  List<Object> get props => [materias];
}

class SuccessMonitoryCreation extends MonitoryCreationState {}

class LoadingState extends MonitoryCreationState {}

class ErrorState extends MonitoryCreationState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
