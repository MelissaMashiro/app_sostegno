import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/network_info.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitories/data/datasources/monitories_local_data_source.dart';
import 'package:app_sostegno/features/monitories/data/datasources/monitories_remote_data_source.dart';
import 'package:app_sostegno/features/monitories/domain/repositories/monitories_repository.dart';

class MonitoriesRepositoryImpl implements MonitoriesRepository {
  final MonitoriesRemoteDataSource remoteDataSource;
  final MonitoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MonitoriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> cancelMonitory(String codMonitory) async {
    try {
      final result = await remoteDataSource.cancelMonitory(codMonitory);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(msg: 'Error al cancelar la monitoria'));
    }
  }

  @override
  Future<Either<Failure, AvailableMonitory>> getMonitoryDetails(
      String codMonitory) async {
    try {
      final monitory = await remoteDataSource.getMonitoryDetails(codMonitory);
      return Right(monitory);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error al pedir detalles de la monitoria'));
    }
  }

  @override
  Future<Either<Failure, List<AvailableMonitory>>>
      getStudentEnrolledMonitories() async {
    if (await networkInfo.isConnected) {
      print('Conectado');
      try {
        final remoteMonitoriesList =
            await remoteDataSource.getStudentEnrolledMonitories();
        localDataSource.saveStudentEnrolledMonitories(remoteMonitoriesList);

        return Right(remoteMonitoriesList);
      } on ServerException {
        return const Left(
            ServerFailure(msg: 'Error al pedir detalles del monitor'));
      }
    } else {
      print('desconectao');

      try {
        final localMonitoriesList =
            await localDataSource.getStudentLastEnrolledMonitories();
        return Right(localMonitoriesList);
      } on CacheException {
        return const Left(
            CacheFailure(msg: 'Error trayendo la Informacion de cache '));
      }
    }
  }

  @override
  Future<Either<Failure, List<MonitorMonitoria>>> getMateriasByMonitor() async {
    try {
      final materiasList = await remoteDataSource.getMateriasByMonitor();
      return Right(materiasList);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error al pedir detalles del monitor'));
    }
  }

  @override
  Future<Either<Failure, List<MonitorMonitoria>>> getMateriasByMonitorWithCode(
      int codMonitor) async {
    try {
      final materiasList =
          await remoteDataSource.getMateriasByMonitorWithCode(codMonitor);
      return Right(materiasList);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error al pedir detalles del monitor'));
    }
  }

  @override
  Future<Either<Failure, List<AvailableMonitory>>>
      getMonitoriesByMonitor() async {
    if (await networkInfo.isConnected) {
      print('Conectado');
      try {
        final myRemoteMonitoriesList =
            await remoteDataSource.getMonitoriesByMonitor();
        localDataSource.saveMonitorMonitories(myRemoteMonitoriesList);

        return Right(myRemoteMonitoriesList);
      } on ServerException {
        return const Left(
            ServerFailure(msg: 'Error al pedir detalles del monitor'));
      }
    } else {
      print('desconectao');

      try {
        final myLocalMonitoriesList =
            await localDataSource.getLastMonitoriesByMonitor();
        return Right(myLocalMonitoriesList);
      } on CacheException {
        return const Left(
            CacheFailure(msg: 'Error trayendo la Informacion de cache '));
      }
    }
  }

  @override
  Future<Either<Failure, List<AvailableMonitory>>>
      getMonitorMonitoriesByMateria(
          String codMonitor, String codMateria) async {
    try {
      final myOwnMonitoriesListByMateria = await remoteDataSource
          .getMonitorMonitoriesByMateria(codMonitor, codMateria);
      return Right(myOwnMonitoriesListByMateria);
    } on ServerException {
      return const Left(
          ServerFailure(msg: 'Error al pedir detalles del monitor'));
    }
  }
}
