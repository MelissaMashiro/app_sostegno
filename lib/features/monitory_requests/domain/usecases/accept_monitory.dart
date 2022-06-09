import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/monitory_requests/domain/repositories/monitory_requests_repository.dart';

class AcceptMonitory {
  final MonitoryRequestsRepository _repository;

  AcceptMonitory(this._repository);

  Future<Either<Failure, void>> call(
      {required Map<String, dynamic> body}) async {
    return await _repository.acceptMonitory(body);
  }
}
