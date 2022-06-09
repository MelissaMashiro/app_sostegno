part of 'monitor_monitories_bloc.dart';

abstract class MonitorMonitoriesEvent extends Equatable {
  const MonitorMonitoriesEvent();

  @override
  List<Object> get props => [];
}

class InitialPageEvent extends MonitorMonitoriesEvent {
  

  const InitialPageEvent();
  @override
  List<Object> get props => [];
}

class DoMateriaSelectedEvent extends MonitorMonitoriesEvent {
  final int codMateria;

  const DoMateriaSelectedEvent({required this.codMateria});

  @override
  List<Object> get props => [codMateria];
}

