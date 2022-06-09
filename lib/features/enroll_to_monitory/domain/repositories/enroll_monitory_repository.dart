import 'package:dartz/dartz.dart';
import 'package:app_sostegno/core/error/failure.dart';
import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/materia.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/monitor.dart';

abstract class EnrollMonitoryRepository {
  Future<Either<Failure, List<AvailableMonitory>>> getAvailableMonitories(
    CustomMateria materia,
    Monitor? monitor,
  );
  Future<Either<Failure, List<CustomMateria>>> getAllMaterias();
  Future<Either<Failure, List<Monitor>>> getMonitoresByMateria(
      int codigoMateria);
  Future<Either<Failure, void>> enrollToMonitory(
    String codMonitory,
  );
}
