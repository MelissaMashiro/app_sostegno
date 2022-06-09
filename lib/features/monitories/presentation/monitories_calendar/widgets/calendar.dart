import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:app_sostegno/core/dialogs/message_dialog.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/monitories/presentation/monitories_calendar/bloc/monitories_calendar_bloc.dart';
import 'package:app_sostegno/routes/routes_name.dart';
import 'package:table_calendar/table_calendar.dart';

import 'my_calendar_card.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({
    Key? key,
    required this.personType,
  }) : super(key: key);

  final int personType;
  @override
  MyCalendarState createState() => MyCalendarState();
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class MyCalendarState extends State<MyCalendar> with TickerProviderStateMixin {
  late ValueNotifier<List<AvailableMonitory>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late LinkedHashMap<DateTime, List<AvailableMonitory>> kEvents =
      LinkedHashMap<DateTime, List<AvailableMonitory>>();
  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

  List<AvailableMonitory> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: kDarkBlue,
        letterSpacing: 0.2,
        fontSize: 16,
      ),
      child: BlocConsumer<MonitoriesCalendarBloc, MonitoriesCalendarState>(
        listener: (context, state) {
          if (state is CalendarError) {
            errorDialog(
              context,
              title: 'Error Inesperado',
              msg: 'Ha ocurrido un error, por favor intente de nuevo',
              action: () {
                Get.offNamedUntil(
                  RoutesName.My_CALENDAR,
                  (route) => false,
                );
              },
            );
          }
          if (state is EnrolledMonitoriesCalendarLoaded) {
            kEvents = LinkedHashMap<DateTime, List<AvailableMonitory>>(
              equals: isSameDay,
              hashCode: getHashCode,
            )..addAll(state.mapMonitories);

            _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
          }
        },
        builder: (context, state) {
          if (state is LoadingCalendarState) {
            return Center(
              child: Image.asset('assets/gifs/studying.gif'),
            );
          } else if (state is EnrolledMonitoriesCalendarLoaded) {
            return Column(
              children: [
                TableCalendar<AvailableMonitory>(
                  locale: Localizations.localeOf(context).languageCode,
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: CalendarFormat.week,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                    selectedDecoration:
                        BoxDecoration(color: kDarkBlue, shape: BoxShape.circle),
                    markersAlignment: Alignment.topCenter,
                    markerDecoration: BoxDecoration(
                      color: kMainPinkColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: _onDaySelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ValueListenableBuilder<List<AvailableMonitory>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return MyCalendarCard(
                            monitory: value[index],
                            onVerTap: () => Get.toNamed(
                              RoutesName.MONITORY_DETAILS,
                              arguments: {
                                'personType': widget.personType,
                                'monitorySelected': value[index],
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }
}
