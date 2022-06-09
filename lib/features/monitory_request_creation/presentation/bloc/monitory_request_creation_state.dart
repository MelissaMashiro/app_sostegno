part of 'monitory_request_creation_bloc.dart';

abstract class MonitoryRequestCreationState extends Equatable {
  const MonitoryRequestCreationState();
  
  @override
  List<Object> get props => [];
}

class MonitoryRequestCreationInitial extends MonitoryRequestCreationState {}


class MateriasRetrieved extends MonitoryRequestCreationState {
  final List<CustomMateria> materias;

  const MateriasRetrieved({
    required this.materias,
  });

  @override
  List<Object> get props => [materias];
}

class SuccessRequestCreation extends MonitoryRequestCreationState {}

class LoadingState extends MonitoryRequestCreationState {}

class ErrorState extends MonitoryRequestCreationState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
