import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';

abstract class MonitoriesRepository {
  Future<Either<Failure, List<AvailableMonitory>>>
      getStudentEnrolledMonitories();
  Future<Either<Failure, List<MonitorMonitoria>>> getMateriasByMonitor();
  Future<Either<Failure, List<MonitorMonitoria>>> getMateriasByMonitorWithCode(
      int codMonitor);
  Future<Either<Failure, List<AvailableMonitory>>> getMonitoriesByMonitor();
  Future<Either<Failure, List<AvailableMonitory>>>
      getMonitorMonitoriesByMateria(String codMonitor, String codMateria);
  Future<Either<Failure, AvailableMonitory>> getMonitoryDetails(
      String codMonitory);
  Future<Either<Failure, void>> cancelMonitory(String codMonitory);
}
