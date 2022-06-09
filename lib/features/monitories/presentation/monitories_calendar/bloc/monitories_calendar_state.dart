part of 'monitories_calendar_bloc.dart';

abstract class MonitoriesCalendarState extends Equatable {
  const MonitoriesCalendarState();

  @override
  List<Object> get props => [];
}

class MonitoriesCalendarInitial extends MonitoriesCalendarState {}

class EnrolledMonitoriesCalendarLoaded extends MonitoriesCalendarState {
  final Map<DateTime, List<AvailableMonitory>> mapMonitories;

  const EnrolledMonitoriesCalendarLoaded({required this.mapMonitories});
}


class LoadingCalendarState extends MonitoriesCalendarState {}

class CalendarError extends MonitoriesCalendarState {
  final String msg;

  const CalendarError({required this.msg});

  @override
  List<Object> get props => [msg];
}
