import 'dart:io';

import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';

abstract class MonitoryCreationRemoteDataSource {
  Future<void> createMonitory({required Map<String, dynamic> body});
}

class MonitoryCreationRemoteDataSourceImpl
    implements MonitoryCreationRemoteDataSource {
  final Dio dio;
  final MySharedPreferences sharedPreferences;

  MonitoryCreationRemoteDataSourceImpl({
    required this.sharedPreferences,
    required this.dio,
  }) {
    dio.options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
    );
  }

  @override
  Future<void> createMonitory({
    required Map<String, dynamic> body,
  }) async {
    final userData = await sharedPreferences.getUser();
    try {
      MonitorMonitoria? porcentaje;
      if (body['idRequest'] != null) {
        final materia = body['materia'];
        final porcentajes = userData!.person.porcentajes!;
        for (var por in porcentajes) {
          if (por.materia.nombre == materia) {
            porcentaje = por;
          }
        }
      } else {
        porcentaje = body['porcentaje'] as MonitorMonitoria;
      }

      final data = {
        'idMonitorMonitoria': porcentaje!.id,
        'fecha': '${body['day']} ${body['horaInicio']}',
        'fin': body['horaFin'],
        'modalidad': body['modality'],
        'detalles': body['detalles'],
      };
      await dio.post(
        AppEndpoints.createMonitory,
        data: data,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
          },
        ),
      );

      if (body['idRequest'] != null) {
        await dio.delete(
          '${AppEndpoints.removeRequest}${body['idRequest']}/',
          data: data,
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Token ${userData.accessToken}',
            },
          ),
        );
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
