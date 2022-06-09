import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/authentication/domain/repositories/authentication_repository.dart';

class LogoutUser {
  final AuthenticationRepository
      _authRepository; //se usara este repositorio que e suna calse abstracta, entonces podra recibir cualquier implementacon de este(lo q cambiará son las implementaciones usadas)

  LogoutUser(this._authRepository);

  Future<Either<Failure, void>> call() async {
    return await _authRepository.logout();
  }
}
