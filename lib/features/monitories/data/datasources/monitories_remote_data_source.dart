import 'dart:io';

import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';

abstract class MonitoriesRemoteDataSource {
  Future<List<AvailableMonitory>> getStudentEnrolledMonitories();
  Future<List<MonitorMonitoria>> getMateriasByMonitor();
  Future<List<MonitorMonitoria>> getMateriasByMonitorWithCode(int codMonitor);
  Future<List<AvailableMonitory>> getMonitoriesByMonitor();
  Future<List<AvailableMonitory>> getMonitorMonitoriesByMateria(
      String codMonitor, String codMateria);
  Future<AvailableMonitory> getMonitoryDetails(String codMonitory);
  Future<void> cancelMonitory(String codMonitory);
}

class MonitoriesRemoteDataSourceImpl implements MonitoriesRemoteDataSource {
  final Dio dio;
  final MySharedPreferences sharedPreferences;

  MonitoriesRemoteDataSourceImpl({
    required this.dio,
    required this.sharedPreferences,
  }) {
    dio.options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
      headers: {
        // HttpHeaders.authorizationHeader:  token.isNotEmpty ? 'Bearer $token' : '',
      },
    );
  }

  @override
  Future<void> cancelMonitory(String codMonitory) async {
    try {
      final userData = await sharedPreferences.getUser();

      await dio.delete(
        '${AppEndpoints.deleteMonitory}$codMonitory/',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
          },
        ),
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<AvailableMonitory> getMonitoryDetails(String codMonitory) {
    try {
      if (codMonitory == '8599') {
        // ignore: null_argument_to_non_null_type
        return Future.value();
      } else {
        // ignore: null_argument_to_non_null_type
        return Future.value();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<AvailableMonitory>> getStudentEnrolledMonitories() async {
    try {
      final userData = await sharedPreferences.getUser();

      final resp = await dio.post(
        AppEndpoints.obtainEnrolledMonitoriesByStudent,
        data: {'idEstudiante': userData!.person.id},
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData.accessToken}',
          },
        ),
      );
      final monitorias = (resp.data as List)
          .map((x) => AvailableMonitory.fromMap(x['monitoria']))
          .toList();

      return monitorias;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MonitorMonitoria>> getMateriasByMonitor() async {
    try {
      final userData = await sharedPreferences.getUser();

      final resp = await dio.get(
        '${AppEndpoints.getMateriasByMonitor}${userData!.person.id}',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData.accessToken}',
          },
        ),
      );
      final monitor = AvailableMonitor.fromMap(resp.data);
      return monitor.porcentajes;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MonitorMonitoria>> getMateriasByMonitorWithCode(
      int codMonitor) async {
    try {
      final userData = await sharedPreferences.getUser();

      final resp = await dio.get(
        '${AppEndpoints.getMateriasByMonitor}$codMonitor',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
          },
        ),
      );
      final monitor = AvailableMonitor.fromMap(resp.data);
      return monitor.porcentajes;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<AvailableMonitory>> getMonitoriesByMonitor() async {
    try {
      final userData = await sharedPreferences.getUser();

      final resp = await dio.post(
        AppEndpoints.monitoriesByMonitor,
        data: {'idMonitor': userData!.person.id},
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData.accessToken}',
          },
        ),
      );
      final monitorias =
          (resp.data as List).map((x) => AvailableMonitory.fromMap(x)).toList();

      return monitorias;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<AvailableMonitory>> getMonitorMonitoriesByMateria(
      String codMonitor, String codMateria) {
    try {
      if (codMonitor == '001' && codMateria == '1234') {
        return Future.value([]);
      } else {
        return Future.value(const []);
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
