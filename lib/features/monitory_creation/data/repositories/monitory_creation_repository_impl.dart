import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/features/monitory_creation/data/datasources/monitory_creation_remote_data_source.dart';
import 'package:app_sostegno/features/monitory_creation/domain/repositories/monitory_creation_repository.dart';

class MonitoryCreationRepositoryImpl implements MonitoryCreationRepository {
  final MonitoryCreationRemoteDataSource remoteDataSource;

  MonitoryCreationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> createMonitory(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.createMonitory(body: body);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(msg: 'Error al crear monitoriaa'));
    }
  }
}
