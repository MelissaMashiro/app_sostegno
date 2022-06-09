part of 'monitory_requests_bloc.dart';

abstract class MonitoryRequestsEvent extends Equatable {
  const MonitoryRequestsEvent();

  @override
  List<Object> get props => [];
}


class InitialPageEvent extends MonitoryRequestsEvent {}

class DoAcceptRequestEvent extends MonitoryRequestsEvent {
  final String codRequest;

  const DoAcceptRequestEvent({required this.codRequest});

  @override
  List<Object> get props => [codRequest];
}

class DoRefuseRequestEvent extends MonitoryRequestsEvent {
  final String codRequest;

  const DoRefuseRequestEvent({required this.codRequest});

  @override
  List<Object> get props => [codRequest];
}