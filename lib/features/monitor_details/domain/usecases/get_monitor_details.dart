import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/monitor_details/monitor_details.dart';

class GetMonitorDetails {
  final MonitorDetailsRepository _repository;

  GetMonitorDetails(this._repository);
  Future<Either<Failure, AvailableMonitor>> call(
      {required String codMonitor}) async {
    return await _repository.getMonitorDetails(codMonitor);
  }
}
