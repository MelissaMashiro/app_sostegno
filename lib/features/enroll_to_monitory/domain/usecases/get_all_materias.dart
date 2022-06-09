import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/materia.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/repositories/enroll_monitory_repository.dart';

class GetAllMaterias {
  final EnrollMonitoryRepository _repository;

  GetAllMaterias(this._repository);

  Future<Either<Failure, List<CustomMateria>>> call() async {
    return await _repository.getAllMaterias();
  }
}
