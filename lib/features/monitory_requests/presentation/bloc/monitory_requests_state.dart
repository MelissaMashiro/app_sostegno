part of 'monitory_requests_bloc.dart';

abstract class MonitoryRequestsState extends Equatable {
  const MonitoryRequestsState();
  
  @override
  List<Object> get props => [];
}

class MonitoryRequestsInitial extends MonitoryRequestsState {}



class RequestsRetrieved extends MonitoryRequestsState {
  final List<Request> requests;

  const RequestsRetrieved({
    required this.requests,
  });
}
class LoadingState extends MonitoryRequestsState {}

class ErrorState extends MonitoryRequestsState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
