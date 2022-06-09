part of 'monitor_details_bloc.dart';

abstract class MonitorDetailsEvent extends Equatable {
  const MonitorDetailsEvent();

  @override
  List<Object> get props => [];
}
 

class SelectedMonitor extends MonitorDetailsEvent {
  final String codMonitor;

  const SelectedMonitor({required this.codMonitor});
}
 