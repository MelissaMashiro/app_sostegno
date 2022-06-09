import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/monitory_creation/domain/repositories/monitory_creation_repository.dart';

class CreateMonitory {
  final MonitoryCreationRepository _repository;

  CreateMonitory(this._repository);

  Future<Either<Failure, void>> call(
      {required Map<String, dynamic> body}) async {
    return await _repository.createMonitory(body);
  }
}
