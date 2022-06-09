import 'dart:io';

import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';

abstract class MonitoryRequestCreationRemoteDataSource {
  Future<void> createMonitoryRequest({required Map<String, dynamic> body});
}

class MonitoryRequestCreationRemoteDataSourceImpl
    implements MonitoryRequestCreationRemoteDataSource {
  final Dio dio;
  final MySharedPreferences sharedPreferences;

  MonitoryRequestCreationRemoteDataSourceImpl({
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
  Future<void> createMonitoryRequest({
    required Map<String, dynamic> body,
  }) async {
    try {
      final userData = await sharedPreferences.getUser();

      final data = {
        'fecha': '${body['day']} ${body['horaInicio']}',
        'fin': body['horaFin'],
        'idMateria': body['materia'].id,
      };
      await dio.post(
        AppEndpoints.createRequest,
        data: data,
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
}
