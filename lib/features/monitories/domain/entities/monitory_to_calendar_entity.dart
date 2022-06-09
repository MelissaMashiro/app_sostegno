import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';

class MonitoryToCalendar {
  MonitoryToCalendar({
    required this.date,
    required this.monitoriesList,
  });

  DateTime date;
  List<AvailableMonitory> monitoriesList;
}
