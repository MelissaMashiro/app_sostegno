import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/monitories/domain/repositories/monitories_repository.dart';

class CancelMonitory {
  final MonitoriesRepository _repository;

  CancelMonitory(this._repository);

  Future<Either<Failure, void>> call({required String codMonitory}) async {
    return await _repository.cancelMonitory(codMonitory);
  }
}
