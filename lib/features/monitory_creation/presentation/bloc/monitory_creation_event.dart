part of 'monitory_creation_bloc.dart';

abstract class MonitoryCreationEvent extends Equatable {
  const MonitoryCreationEvent();

  @override
  List<Object> get props => [];
}

class InitialMonitoryCreationEvent extends MonitoryCreationEvent {}

class DoCreateMonitory extends MonitoryCreationEvent {
}
