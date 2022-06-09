part of 'monitor_details_bloc.dart';

abstract class MonitorDetailsState extends Equatable {
  const MonitorDetailsState();

  @override
  List<Object> get props => [];
}

class InitialMonitorDetails extends MonitorDetailsState {}

class MonitorDetailsRetrieved extends MonitorDetailsState {
  final AvailableMonitor monitor;

  const MonitorDetailsRetrieved({required this.monitor});
}

class CanceledMonitory extends MonitorDetailsState {}

class LoadingState extends MonitorDetailsState {}

class ErrorState extends MonitorDetailsState {
  final String msg;

  const ErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
