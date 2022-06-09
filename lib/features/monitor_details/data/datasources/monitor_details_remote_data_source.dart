import 'dart:io';

import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';

abstract class MonitorDetailsRemoteDataSource {
  Future<AvailableMonitor> getMonitorDetails(String codMonitor);
}

class MonitorDetailsRemoteDataSourceImpl
    implements MonitorDetailsRemoteDataSource {
  final Dio dio;
  final MySharedPreferences sharedPreferences;
  MonitorDetailsRemoteDataSourceImpl({
    required this.dio,
    required this.sharedPreferences,
  }) {
    dio.options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
    );
  }

  @override
  Future<AvailableMonitor> getMonitorDetails(String codMonitor) async {
    try {
      final userData = await sharedPreferences.getUser();
      final resp = await dio.get(
        AppEndpoints.monitorDetails + codMonitor,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
          },
        ),
      );
      final monitor = AvailableMonitor.fromMap(resp.data);

      return monitor;
    } catch (e) {
      throw ServerException();
    }
  }
}
