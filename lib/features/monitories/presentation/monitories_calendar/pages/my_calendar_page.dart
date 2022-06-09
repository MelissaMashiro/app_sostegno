import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/core/storage/shared_preferences_impl.dart';
import 'package:app_sostegno/core/utils/constants.dart';
import 'package:app_sostegno/core/side_bar/drawer_menu.dart';
import 'package:app_sostegno/core/widgets/purple_header.dart';
import 'package:app_sostegno/features/authentication/authentication.dart';
import 'package:app_sostegno/features/monitories/presentation/monitories_calendar/bloc/monitories_calendar_bloc.dart';
import 'package:app_sostegno/features/monitories/presentation/monitories_calendar/widgets/calendar.dart';
import 'package:app_sostegno/injection_container.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({Key? key}) : super(key: key);

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  MySharedPreferences sharedPreferences = MySharedPreferencesImpl();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _drawerKey,
        backgroundColor: kGrayBackgroundColor,
        drawer: InkWellDrawer(
          context: context,
        ),
        body: Column(
          children: [
            PurpleHeader(
              title: 'Mi Calendario',
              onPressed: () {
                _drawerKey.currentState!.openDrawer();
              },
              icon: Icons.list,
            ),
            FutureBuilder<UserEntity?>(
              future: sharedPreferences.getUser(),
              builder: (
                BuildContext context,
                AsyncSnapshot<UserEntity?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Image.asset('assets/gifs/studying_lila.gif'),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Image.asset('assets/gifs/studying_lila.gif'),
                  );
                } else {
                  final personType = snapshot.data!.personType;
                  return Expanded(
                    child: BlocProvider(
                      create: (_) => sl<MonitoriesCalendarBloc>()
                        ..add(InitialCalendarLoad(userType: personType)),
                      child: MyCalendar(
                        personType: personType,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
