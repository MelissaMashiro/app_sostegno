import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_sostegno/features/enroll_to_monitory/domain/entities/materia.dart';

abstract class EnrollMonitoryLocalDataSource {
  Future<void> saveMaterias(List<CustomMateria> materias);
  Future<List<CustomMateria>> getLastMaterias();
}

// ignore: constant_identifier_names
const CACHED_MATERIAS = 'CACHED_MATERIAS';

class EnrollMonitoryLocalDataSourceImpl
    implements EnrollMonitoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  EnrollMonitoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CustomMateria>> getLastMaterias() {
    final jsonString = sharedPreferences.getString(CACHED_MATERIAS);
    Iterable jsonList = json.decode(jsonString!);
    List<CustomMateria> cachedMaterias = List<CustomMateria>.from(
      jsonList.map(
        (model) => CustomMateria.fromMap(model),
      ),
    );
    return Future.value(cachedMaterias);
  }

  @override
  Future<void> saveMaterias(List<CustomMateria> materias) async {
    sharedPreferences.setString(
      CACHED_MATERIAS,
      jsonEncode(materias.map((i) => i.toMap()).toList()).toString(),
    );
  }
}
