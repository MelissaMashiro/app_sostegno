import 'dart:io';

import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/materia.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/monitor.dart';

abstract class EnrollMonitoryRemoteDataSource {
  Future<List<AvailableMonitory>> getAvailableMonitories(
    CustomMateria materia,
    Monitor? monitor,
  );
  Future<List<CustomMateria>> getAllMaterias();
  Future<List<Monitor>> getMonitoresByMateria(int codigoMateria);
  Future<void> enrollToMonitory(
    String codMonitory,
  );
}

class EnrollMonitoryRemoteDataSourceImpl
    implements EnrollMonitoryRemoteDataSource {
  final Dio dio;
  final MySharedPreferences sharedPreferences;

  EnrollMonitoryRemoteDataSourceImpl({
    required this.dio,
    required this.sharedPreferences,
  }) {
    dio.options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
      headers: {},
    );
  }

  @override
  Future<List<CustomMateria>> getAllMaterias() async {
    final userData = await sharedPreferences.getUser();
    try {
      final resp = await dio.get(
        AppEndpoints.getAllMaterias,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
          },
        ),
      );

      final materias =
          (resp.data as List).map((x) => CustomMateria.fromMap(x)).toList();

      return materias;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<Monitor>> getMonitoresByMateria(int codigoMateria) async {
    try {
      final userData = await sharedPreferences.getUser();

      final resp = await dio.post(
        AppEndpoints.getMonitoresByMateria,
        data: {
          'materia': codigoMateria,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
          },
        ),
      );
      final monitores =
          (resp.data as List).map((x) => Monitor.fromMap(x)).toList();
      return monitores;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<AvailableMonitory>> getAvailableMonitories(
    CustomMateria materia,
    Monitor? monitor,
  ) async {
    try {
      final userData = await sharedPreferences.getUser();
      Response resp;
      if (monitor != null) {
        resp = await dio.post(
          AppEndpoints.getMateriasByMateriaAndMonitor,
          data: {
            'idMateria': materia.id,
            'idMonitor': monitor.id,
          },
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
            },
          ),
        );
      } else {
        resp = await dio.post(
          AppEndpoints.monitoriesByGeneralMateria,
          data: {
            'materia': materia.materia.nombre,
          },
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
            },
          ),
        );
      }
      final monitories =
          (resp.data as List).map((x) => AvailableMonitory.fromMap(x)).toList();
      return monitories;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> enrollToMonitory(
    String codMonitory,
  ) async {
    try {
      final userData = await sharedPreferences.getUser();

      await dio.post(
        AppEndpoints.enrollMonitory,
        data: {'idMonitoria': codMonitory, 'idEstudiante': userData!.person.id},
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData.accessToken}',
          },
        ),
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
