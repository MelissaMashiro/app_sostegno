part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}


class SuccessfullAuthenticatedState extends AuthenticationState{}

class LoadingState extends AuthenticationState {}

class ErrorState extends AuthenticationState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
