part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class DoLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final int userType;

  const DoLoginEvent({
    required this.email,
    required this.password,
    required this.userType, 
  });
}

class DoLogoutEvent extends AuthenticationEvent {}
