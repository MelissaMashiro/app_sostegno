import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/register/domain/entities/university_entity.dart';

abstract class RegisterRepository {
  Future<Either<Failure, List<University>>> getBarranquillaUniversities();

  Future<Either<Failure, void>> registerUser(
      {required Map<String, dynamic> body});
}
