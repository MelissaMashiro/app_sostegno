import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';

abstract class MonitoriesLocalDataSource {
  Future<List<AvailableMonitory>> getStudentLastEnrolledMonitories();
  Future<List<AvailableMonitory>> getLastMonitoriesByMonitor();
  Future<void> saveStudentEnrolledMonitories(
      List<AvailableMonitory> monitories);
  Future<void> saveMonitorMonitories(List<AvailableMonitory> monitories);
}

const CACHED_ENROLLED_MONITORIES = 'CACHED_ENROLLED_MONITORIES';
const CACHED_OWN_MONITORIES = 'CACHED_OWN_MONITORIES';

class MonitoriesLocalDataSourceImpl implements MonitoriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  MonitoriesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<AvailableMonitory>> getStudentLastEnrolledMonitories() {
    final jsonString = sharedPreferences.getString(CACHED_ENROLLED_MONITORIES);
    Iterable jsonList = json.decode(jsonString!);
    List<AvailableMonitory> cachedMonitories = List<AvailableMonitory>.from(
      jsonList.map(
        (model) => AvailableMonitory.fromMap(model),
      ),
    );
    return Future.value(cachedMonitories);
  }

  @override
  Future<List<AvailableMonitory>> getLastMonitoriesByMonitor() {
    final jsonString = sharedPreferences.getString(CACHED_OWN_MONITORIES);
    Iterable jsonList = json.decode(jsonString!);
    List<AvailableMonitory> cachedMonitories = List<AvailableMonitory>.from(
      jsonList.map(
        (model) => AvailableMonitory.fromMap(model),
      ),
    );
    return Future.value(cachedMonitories);
  }

  @override
  Future<void> saveStudentEnrolledMonitories(
      List<AvailableMonitory> monitories) async {}

  @override
  Future<void> saveMonitorMonitories(List<AvailableMonitory> monitories) async {
    sharedPreferences.setString(
      CACHED_OWN_MONITORIES,
      jsonEncode(monitories.map((i) => i.toJson()).toList()).toString(),
    );
  }
}
