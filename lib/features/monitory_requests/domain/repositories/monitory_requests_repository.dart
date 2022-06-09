import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/monitory_requests/domain/entities/request_entity.dart';

abstract class MonitoryRequestsRepository {
  Future<Either<Failure, List<Request>>> getRequestedMonitories();
  Future<Either<Failure, void>> acceptMonitory(Map<String, dynamic> body);
}
