import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/monitories/domain/repositories/monitories_repository.dart';

class GetMonitoriesByMonitor {
  final MonitoriesRepository _repository;

  GetMonitoriesByMonitor(this._repository);

  Future<Either<Failure, List<AvailableMonitory>>> call() async {
    return await _repository.getMonitoriesByMonitor();
  }
}
