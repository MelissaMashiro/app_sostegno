part of 'monitory_details_bloc.dart';

abstract class MonitoryDetailsEvent extends Equatable {
  const MonitoryDetailsEvent();

  @override
  List<Object> get props => [];
}
 

class SelectedMonitory extends MonitoryDetailsEvent {
  final String codMonitory;

  const SelectedMonitory({required this.codMonitory});
}

class SelectedMonitorInfo extends MonitoryDetailsEvent {
  final String codMonitor;

  const SelectedMonitorInfo({required this.codMonitor});
}

class CancelMonitoryEvent extends MonitoryDetailsEvent {
  final String codMonitory;

  const CancelMonitoryEvent({required this.codMonitory});
}