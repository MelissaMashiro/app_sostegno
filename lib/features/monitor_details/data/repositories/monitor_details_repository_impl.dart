import 'package:app_sostegno/core/error/exception.dart';
import 'package:app_sostegno/core/network_info.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitor_details/data/datasources/monitor_details_remote_data_source.dart';
import 'package:app_sostegno/features/monitor_details/domain/repositories/monitor_details_repository.dart';

class MonitorDetailsRepositoryImpl implements MonitorDetailsRepository {
  final MonitorDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MonitorDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AvailableMonitor>> getMonitorDetails(
      String codMonitor) async {
    try {
      final monitor = await remoteDataSource.getMonitorDetails(codMonitor);
      return Right(monitor);
    } on ServerException {
      return const Left(
        ServerFailure(msg: 'Error al pedir detalles del monitor'),
      );
    }
  }
}
