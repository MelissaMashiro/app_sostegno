import 'dart:io';

import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/storage/shared_preferences.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';

abstract class MonitoryRequestsRemoteDataSource {
  Future<List<Request>> getRequestedMonitories();
  Future<void> acceptMonitory({required Map<String, dynamic> body});
}

class MonitoryRequestsRemoteDataSourceImpl
    implements MonitoryRequestsRemoteDataSource {
  final Dio dio;
  final MySharedPreferences sharedPreferences;

  MonitoryRequestsRemoteDataSourceImpl({
    required this.dio,
    required this.sharedPreferences,
  }) {
    dio.options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
    );
  }

  @override
  Future<void> acceptMonitory({required Map<String, dynamic> body}) async {
    try {} catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<Request>> getRequestedMonitories() async {
    final userData = await sharedPreferences.getUser();

    try {
      final resp = await dio.get(
        AppEndpoints.obtaingRequestsByMonitor,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Token ${userData!.accessToken}',
          },
        ),
      );
      final requests =
          (resp.data as List).map((x) => Request.fromMap(x)).toList();

      return requests;
    } catch (e) {
      throw ServerException();
    }
  }
}
