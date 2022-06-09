import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/monitor.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/repositories/enroll_monitory_repository.dart';

class GetMonitoresByMateria {
  final EnrollMonitoryRepository _repository;

  GetMonitoresByMateria(this._repository);
  Future<Either<Failure, List<Monitor>>> call(
      {required int codigoMateria}) async {
    return await _repository.getMonitoresByMateria(codigoMateria);
  }
}
