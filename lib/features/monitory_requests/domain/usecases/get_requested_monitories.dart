import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';
import 'package:app_sostegno/features/monitory_requests/domain/repositories/monitory_requests_repository.dart';

class GetRequestedMonitories {
  final MonitoryRequestsRepository _repository;

  GetRequestedMonitories(this._repository);

  Future<Either<Failure, List<Request>>> call() async {
    return await _repository.getRequestedMonitories();
  }
}
