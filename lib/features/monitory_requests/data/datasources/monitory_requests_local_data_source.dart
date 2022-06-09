import 'dart:convert';

import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';

abstract class MonitoryRequestsLocalDataSource {
  Future<List<Request>> getLastRequestedMonitories();
  Future<void> saveRequestedMonitories(List<Request> requests);
}

// ignore: constant_identifier_names
const CACHED_REQUESTED_MONITORIES = 'CACHED_REQUESTED_MONITORIES';

class MonitoryRequestsLocalDataSourceImpl
    implements MonitoryRequestsLocalDataSource {
  final SharedPreferences sharedPreferences;

  MonitoryRequestsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Request>> getLastRequestedMonitories() {
    final jsonString = sharedPreferences.getString(CACHED_REQUESTED_MONITORIES);
    Iterable jsonList = json.decode(jsonString!);
    List<Request> cachedMonitories = List<Request>.from(
      jsonList.map(
        (model) => AvailableMonitory.fromMap(model),
      ),
    );
    return Future.value(cachedMonitories);
  }

  @override
  Future<void> saveRequestedMonitories(List<Request> monitories) async {
    sharedPreferences.setString(
      CACHED_REQUESTED_MONITORIES,
      jsonEncode(monitories.map((i) => i.toMap()).toList()).toString(),
    );
  }
}
