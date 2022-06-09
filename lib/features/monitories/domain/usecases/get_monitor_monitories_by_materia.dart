import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitories/domain/repositories/monitories_repository.dart';

class GetMonitorMonitoriesByMateria {
  final MonitoriesRepository _repository;

  GetMonitorMonitoriesByMateria(this._repository);

  Future<Either<Failure, List<AvailableMonitory>>> call(
      {required String codMonitor, required String codMateria}) async {
    return await _repository.getMonitorMonitoriesByMateria(
        codMonitor, codMateria);
  }
}
