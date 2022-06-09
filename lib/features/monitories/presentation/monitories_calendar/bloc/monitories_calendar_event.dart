part of 'monitories_calendar_bloc.dart';

abstract class MonitoriesCalendarEvent extends Equatable {
  const MonitoriesCalendarEvent();

  @override
  List<Object> get props => [];
}

class InitialCalendarLoad extends MonitoriesCalendarEvent {
  final int userType;

  const InitialCalendarLoad({required this.userType});
}
