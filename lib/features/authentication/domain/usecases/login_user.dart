import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/authentication/domain/entities/user_entity.dart';
import 'package:app_sostegno/features/authentication/domain/repositories/authentication_repository.dart';

class LoginUser {
  final AuthenticationRepository
      _authRepository; //se usara este repositorio que e suna calse abstracta, entonces podra recibir cualquier implementacon de este(lo q cambiará son las implementaciones usadas)

  LoginUser(this._authRepository);

  Future<Either<Failure, UserEntity>> call(
      {required String email,
      required String password,
      required int userType}) async {
    return await _authRepository.login(email, password, userType);
  }
}
