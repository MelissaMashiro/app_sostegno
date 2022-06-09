part of 'monitor_monitories_bloc.dart';

abstract class MonitorMonitoriesState extends Equatable {
  const MonitorMonitoriesState();

  @override
  List<Object> get props => [];
}

class MonitorMonitoriesInitial extends MonitorMonitoriesState {}

class InitialDataRetrieved extends MonitorMonitoriesState {
  final List<AvailableMonitory> monitories;
  final List<MonitorMonitoria> materias;

  const InitialDataRetrieved({
    required this.monitories,
    required this.materias,
  });
}

class MonitoriesByMateriaRetrieved extends MonitorMonitoriesState {
  final List<AvailableMonitory> monitories;

  const MonitoriesByMateriaRetrieved({
    required this.monitories,
  });
}

class LoadingMonitoriesState extends MonitorMonitoriesState {}

class MonitoriesError extends MonitorMonitoriesState {
  final String msg;

  const MonitoriesError({required this.msg});

  @override
  List<Object> get props => [msg];
}
