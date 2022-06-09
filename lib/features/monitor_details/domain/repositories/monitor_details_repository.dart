import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';

abstract class MonitorDetailsRepository {
  Future<Either<Failure, AvailableMonitor>> getMonitorDetails(
      String codMonitor);
}
