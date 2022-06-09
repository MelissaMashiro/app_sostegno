import 'package:equatable/equatable.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/monitories/domain/monitories_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'monitories_calendar_event.dart';
part 'monitories_calendar_state.dart';

class MonitoriesCalendarBloc
    extends Bloc<MonitoriesCalendarEvent, MonitoriesCalendarState> {
  final GetStudentEnrolledMonitories getStudentEnrolledMonitories;
  final GetMonitoriesByMonitor getMonitoriesByMonitor;

  final GetMonitoryDetails getMonitoryDetails;

  MonitoriesCalendarBloc({
    required this.getStudentEnrolledMonitories,
    required this.getMonitoriesByMonitor,
    required this.getMonitoryDetails,
  }) : super(MonitoriesCalendarInitial()) {
    on<InitialCalendarLoad>(
      (event, emit) {
        if (event.userType == 0) {
          return _getMonitorMonitoriesToCalendar(event, emit);
        } else {
          return _getEnrolledMonitoriesToCalendar(event, emit);
        }
      },
    );
  }

  Map<DateTime, List<AvailableMonitory>> mapMonitories = {};

  Future<void> _getMonitorMonitoriesToCalendar(
    InitialCalendarLoad event,
    Emitter<MonitoriesCalendarState> emit,
  ) async {
    emit(LoadingCalendarState());

    final failOrMonitories = await getMonitoriesByMonitor();

    emit(
      failOrMonitories.fold(
          (fail) => CalendarError(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting monitor monitories'
                    : 'Ops... Cache failure getting monitor monitories',
              ), (monitories) {
        Map<DateTime, List<AvailableMonitory>> mapMonitoriesToCalendar = {
          for (var e in _getMonitoriesFormattedList(monitories))
            e.date: e.monitoriesList
        };
        mapMonitories = mapMonitoriesToCalendar;
        return EnrolledMonitoriesCalendarLoaded(
            mapMonitories: mapMonitoriesToCalendar);
      }),
    );
  }

  Future<void> _getEnrolledMonitoriesToCalendar(
    InitialCalendarLoad event,
    Emitter<MonitoriesCalendarState> emit,
  ) async {
    emit(LoadingCalendarState());

    final failOrMonitories = await getStudentEnrolledMonitories();

    emit(
      failOrMonitories.fold(
          (fail) => CalendarError(
                msg: fail is ServerFailure
                    ? 'Ops... server failure getting monitor monitories'
                    : 'Ops... Cache failure getting monitor monitories',
              ), (monitories) {
        Map<DateTime, List<AvailableMonitory>> mapMonitoriesToCalendar = {
          for (var e in _getMonitoriesFormattedList(monitories))
            e.date: e.monitoriesList
        };
        mapMonitories = mapMonitoriesToCalendar;
        return EnrolledMonitoriesCalendarLoaded(
            mapMonitories: mapMonitoriesToCalendar);
      }),
    );
  }

  List<MonitoryToCalendar> _getMonitoriesFormattedList(
    List<AvailableMonitory> monitories,
  ) {
    List<MonitoryToCalendar> monitoriesToCalendar = [];

    if (monitories.isNotEmpty) {
      Set listaFinalFechas = {};

      List<DateTime> listaFechas = [];
      for (var d in monitories) {
        listaFechas.add(
          _getMonitoryDateTime(
            d.fecha.toIso8601String().split('T')[0],
            d.fecha.toIso8601String().split('T')[1],
          ),
        );
      }
      listaFinalFechas = Set.from(listaFechas);

      if (listaFinalFechas.isNotEmpty) {
        for (DateTime dateTime in listaFinalFechas) {
          List<AvailableMonitory> monitoriesByDateTime = [];
          for (var m in monitories) {
            var onlyDay = dateTime.toIso8601String().split("T")[0];
            if (onlyDay == m.fecha.toIso8601String().split('T')[0]) {
              monitoriesByDateTime.add(m);
            }
          }
          monitoriesToCalendar.add(MonitoryToCalendar(
              date: dateTime, monitoriesList: monitoriesByDateTime));
        }
      }

      return monitoriesToCalendar;
    }
    return [];
  }
}

DateTime _getMonitoryDateTime(String day, String initialTime) {
  String dateTime = "${day}T$initialTime";
  DateTime parsedDate = DateTime.parse(dateTime);
  return parsedDate;
}
