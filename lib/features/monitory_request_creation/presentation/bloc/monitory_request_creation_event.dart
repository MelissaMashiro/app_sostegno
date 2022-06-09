part of 'monitory_request_creation_bloc.dart';

abstract class MonitoryRequestCreationEvent extends Equatable {
  const MonitoryRequestCreationEvent();

  @override
  List<Object> get props => [];
}

class InitialRequestCreationEvent extends MonitoryRequestCreationEvent {}

class DoCreateRequest extends MonitoryRequestCreationEvent {
}
