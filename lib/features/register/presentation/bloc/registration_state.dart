part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class UniversitiesRetrieved extends RegistrationState {
  final List<University> universities;

  const UniversitiesRetrieved({required this.universities,});
}
class SuccessfullRegistration extends RegistrationState{}
class LoadingState extends RegistrationState {}

class ErrorState extends RegistrationState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
