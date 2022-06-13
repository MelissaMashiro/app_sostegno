import 'package:dio/dio.dart';
import 'package:app_sostegno/core/app_endpoints.dart';
import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/features/register/domain/entities/university_entity.dart';

abstract class RegisterRemoteDataSource {
  Future<List<University>> getBarranquillaUniversities();
  Future<void> registerUser({required Map<String, dynamic> body});
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final Dio dio;

  RegisterRemoteDataSourceImpl({required this.dio}) {
    dio.options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
      headers: {
        'Content-Type': 'application/json'
        // HttpHeaders.authorizationHeader:  token.isNotEmpty ? 'Bearer $token' : '',
      },
    );
  }

  @override
  Future<List<University>> getBarranquillaUniversities() async {
    try {
      final List<University> listaUniversities;
      final resp = await dio.get(
        AppEndpoints.universities,
      );
      listaUniversities =
          resp.data.map<University>((e) => University.fromMap(e)).toList();
      return listaUniversities;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> registerUser({required Map<String, dynamic> body}) async {
    try {
      final data = {
        "email": body['email'],
        "entidad": 1, // body['university'],
        "codigo": body['studentCode'],
        "codigo_registro": body['codigoRegistro'],
        "password": body['password'],
        "password_confirmation": body['password'],
        "first_name": body['first_name'],
        "last_name": body['last_name']
      };
      await dio.post(
        AppEndpoints.register,
        data: data,
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
