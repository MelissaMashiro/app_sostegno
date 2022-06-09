import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/enroll_to_monitory_domain.dart';

class GetAvailableMonitories {
  final EnrollMonitoryRepository
      _repository; // Con esto le digo que reciba este repositorio, entonces cuando haga la injeccion de dependencias le podre meter la implementacion que quiera de este repositorio

  GetAvailableMonitories(this._repository);

  Future<Either<Failure, List<AvailableMonitory>>> call({
    required CustomMateria materia,
    required Monitor? monitor,
  }) async {
    return await _repository.getAvailableMonitories(materia, monitor);
  }
}
