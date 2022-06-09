import 'package:app_sostegno/features/enroll_to_monitory/data/enroll_to_monitory_data.dart';

class Monitor {
  const Monitor({
    required this.id,
    this.monitor,
    this.materia,
    required this.monitoriasCount,
  });

  final int id;
  final MonitorClass? monitor;
  final MateriaByMonitor? materia;
  final int monitoriasCount;

  factory Monitor.fromMap(Map<String, dynamic> json) => Monitor(
        id: json["id"],
        monitor: MonitorClass.fromMap(json["monitor"]),
        materia: MateriaByMonitor.fromMap(json["materia"]),
        monitoriasCount: json["monitorias_count"],
      );
}

class MateriaByMonitor {
  MateriaByMonitor({
    required this.id,
    required this.nombre,
  });

  final int id;
  final String nombre;

  factory MateriaByMonitor.fromMap(Map<String, dynamic> json) =>
      MateriaByMonitor(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}

class MonitorClass {
  MonitorClass(
      {required this.id,
      required this.carrera,
      required this.descripcion,
      required this.monitorUser});

  final int id;
  final String carrera;
  final String descripcion;
  final MonitorUser monitorUser;

  factory MonitorClass.fromMap(Map<String, dynamic> json) => MonitorClass(
        id: json["id"],
        carrera: json["carrera"],
        descripcion: json["descripcion"],
        monitorUser: MonitorUser.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "carrera": carrera,
        "descripcion": descripcion,
      };
}
