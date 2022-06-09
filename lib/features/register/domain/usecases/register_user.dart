import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/register/domain/repositories/register_repository.dart';

class RegisterUser {
  final RegisterRepository _repository;

  RegisterUser(this._repository);

  Future<Either<Failure, void>> call(
      {required Map<String, dynamic> body}) async {
    return await _repository.registerUser(body: body);
  }
}
