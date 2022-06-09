import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';

abstract class MonitoryRequestCreationRepository {
  Future<Either<Failure, void>> createMonitoryRequest(
      Map<String, dynamic> body);
}
