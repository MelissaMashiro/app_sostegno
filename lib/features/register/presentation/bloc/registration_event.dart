part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class InitialPageEvent extends RegistrationEvent {}

class DoRegisterEvent extends RegistrationEvent {
}
