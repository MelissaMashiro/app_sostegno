import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/network_info.dart';
import 'package:app_sostegno/features/authentication/data/datasources/authentication_local_data_source.dart';
import 'package:app_sostegno/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:app_sostegno/features/authentication/domain/entities/user_entity.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password, int userType) async {
    try {
      final remoteUser =
          await remoteDataSource.login(email, password, userType);
      print('RECORDEMOS QUE ESTUDIANTE ES: 1 Y MONITOR ES 2');
      localDataSource.saveAuthenticationData(remoteUser);
      return Right(remoteUser);
    } on ServerException {
      return const Left(ServerFailure(msg: 'Error al loguear'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await remoteDataSource.logout();
      localDataSource.removeAuthenticationToken();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(msg: 'Error al desloguear'));
    }
  }
}
