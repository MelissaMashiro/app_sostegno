import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/features/authentication/domain/entities/user_entity.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserEntity> login(String email, String password, int userType);
  Future<void> logout();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio dio;

  AuthenticationRemoteDataSourceImpl({required this.dio}) {
    dio.options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<UserEntity> login(String email, String password, int userType) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };
      final resp = await dio.post(
        AppEndpoints.login,
        data: body,
      );
      final userEntity = UserEntity.fromMap(resp.data);
      return userEntity;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    try {
      print('deslogueao');
    } catch (e) {
      throw ServerException();
    }
  }
}
