import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/network_info.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/features/monitory_requests/data/datasources/monitory_requests_local_data_source.dart';
import 'package:app_sostegno/features/monitory_requests/data/datasources/monitory_requests_remote_data_source.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';
import 'package:app_sostegno/features/monitory_requests/domain/repositories/monitory_requests_repository.dart';

class MonitoryRequestsRepositoryImpl implements MonitoryRequestsRepository {
  final MonitoryRequestsRemoteDataSource remoteDataSource;
  final MonitoryRequestsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MonitoryRequestsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> acceptMonitory(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.acceptMonitory(body: body);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(msg: 'Error al aceptar monitoria'));
    }
  }

  @override
  Future<Either<Failure, List<Request>>> getRequestedMonitories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRequestedMonitories =
            await remoteDataSource.getRequestedMonitories();
        localDataSource.saveRequestedMonitories(remoteRequestedMonitories);
        return Right(remoteRequestedMonitories);
      } on ServerException {
        return const Left(ServerFailure(
            msg: 'Error obteniendo las monitorias solicitadas remotamente'));
      }
    } else {
      try {
        final localRequestedMonitoriesList =
            await localDataSource.getLastRequestedMonitories();
        return Right(localRequestedMonitoriesList);
      } on CacheException {
        return const Left(CacheFailure(
            msg:
                'Error trayendo la Informacion de cache de las monitorias solicitadas'));
      }
    }
  }
}
