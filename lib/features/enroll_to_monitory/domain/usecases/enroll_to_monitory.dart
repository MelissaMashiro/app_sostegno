import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/repositories/enroll_monitory_repository.dart';

class EnrollToMonitory {
  final EnrollMonitoryRepository _repository;

  EnrollToMonitory(this._repository);
  Future<Either<Failure, void>> call({
    required String codMonitory,
  }) async {
    return await _repository.enrollToMonitory(codMonitory);
  }
}
