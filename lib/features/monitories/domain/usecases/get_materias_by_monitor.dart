import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitories/domain/repositories/monitories_repository.dart';

class GetMateriasByMonitor {
  final MonitoriesRepository _repository;

  GetMateriasByMonitor(this._repository);

  Future<Either<Failure, List<MonitorMonitoria>>> call() async {
    return await _repository.getMateriasByMonitor();
  }
}
