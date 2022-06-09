import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/features/register/data/datasources/register_remote_data_source.dart';
import 'package:app_sostegno/features/register/domain/entities/university_entity.dart';
import 'package:app_sostegno/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;

  RegisterRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<University>>>
      getBarranquillaUniversities() async {
    try {
      final universidades =
          await remoteDataSource.getBarranquillaUniversities();
      return Right(universidades);
    } on ServerException {
      return const Left(ServerFailure(msg: 'Error al pedir universidades'));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(
      {required Map<String, dynamic> body}) async {
    try {
      final result = await remoteDataSource.registerUser(body: body);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(msg: 'Error al registrar usuario'));
    }
  }
}
