import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/network_info.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/enroll_to_monitory_domain.dart';

class EnrollMonitoryRepositoryImpl implements EnrollMonitoryRepository {
  final EnrollMonitoryRemoteDataSource remoteDataSource;
  final EnrollMonitoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  EnrollMonitoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AvailableMonitory>>> getAvailableMonitories(
    CustomMateria materia,
    Monitor? monitor,
  ) async {
    try {
      final remoteMonitories =
          await remoteDataSource.getAvailableMonitories(materia, monitor);
      return Right(remoteMonitories);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error obteniendo las monitorias disponibles'));
    }
  }

  @override
  Future<Either<Failure, List<CustomMateria>>> getAllMaterias() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMaterias = await remoteDataSource.getAllMaterias();
        localDataSource.saveMaterias(remoteMaterias);
        return Right(remoteMaterias);
      } on ServerException {
        return const Left(
            ServerFailure(msg: 'Error obteniendo las materias remotas'));
      }
    } else {
      try {
        final localMaterias = await localDataSource.getLastMaterias();
        return Right(localMaterias);
      } on CacheException {
        return const Left(
            CacheFailure(msg: 'Error trayendo la Informacion de cache '));
      }
    }
  }

  @override
  Future<Either<Failure, List<Monitor>>> getMonitoresByMateria(
      int codigoMateria) async {
    try {
      final remoteMonitorList =
          await remoteDataSource.getMonitoresByMateria(codigoMateria);
      return Right(remoteMonitorList);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error al pedor monitores por materia'));
    }
  }

  @override
  Future<Either<Failure, void>> enrollToMonitory(
    String codMonitory,
  ) async {
    try {
      final result = await remoteDataSource.enrollToMonitory(
        codMonitory,
      );
      return Right(result);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error al suscribirse a la monitoria'));
    }
  }
}
