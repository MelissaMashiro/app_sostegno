import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/monitory_request_creation/domain/repositories/monitory_request_creation_repository.dart';

class CreateMonitoryRequest {
  final MonitoryRequestCreationRepository _repository;

  CreateMonitoryRequest(this._repository);

  Future<Either<Failure, void>> call(
      {required Map<String, dynamic> body}) async {
    return await _repository.createMonitoryRequest(body);
  }
}
