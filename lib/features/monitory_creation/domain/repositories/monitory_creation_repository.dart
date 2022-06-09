import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';

abstract class MonitoryCreationRepository {
  Future<Either<Failure, void>> createMonitory(Map<String, dynamic> body);
}
