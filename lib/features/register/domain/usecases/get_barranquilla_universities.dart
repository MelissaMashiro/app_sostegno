import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/register/domain/entities/university_entity.dart';
import 'package:app_sostegno/features/register/domain/repositories/register_repository.dart';

class GetBarranquillaUniversities {
  final RegisterRepository _repository;

  GetBarranquillaUniversities(this._repository);

  Future<Either<Failure, List<University>>> call() async {
    return await _repository.getBarranquillaUniversities();
  }
}
