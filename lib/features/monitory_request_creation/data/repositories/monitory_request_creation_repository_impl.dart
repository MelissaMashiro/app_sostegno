import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/features/monitory_request_creation/data/datasources/monitory_request_creation_remote_data_source.dart';
import 'package:app_sostegno/features/monitory_request_creation/domain/repositories/monitory_request_creation_repository.dart';

class MonitoryRequestCreationRepositoryImpl
    implements MonitoryRequestCreationRepository {
  final MonitoryRequestCreationRemoteDataSource remoteDataSource;

  MonitoryRequestCreationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> createMonitoryRequest(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.createMonitoryRequest(body: body);
      return Right(result);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error al crear la solicitud de monitoria'));
    }
  }
}
