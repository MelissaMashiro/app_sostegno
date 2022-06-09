class AvailableMonitory {
  AvailableMonitory({
    required this.id,
    required this.monitorMonitoria,
    required this.fecha,
    required this.fin,
    required this.modalidad,
    required this.detalles,
    required this.estado,
  });

  final int id;
  final MonitorMonitoria monitorMonitoria;
  final DateTime fecha;
  final String fin;
  final String modalidad;
  final String detalles;
  final String estado;

  factory AvailableMonitory.fromMap(Map<String, dynamic> json) =>
      AvailableMonitory(
        id: json["id"],
        monitorMonitoria: MonitorMonitoria.fromMap(json["monitor_monitoria"]),
        fecha: DateTime.parse(json["fecha"]),
        fin: json["fin"],
        modalidad: json["modalidad"],
        detalles: json["detalles"],
        estado: json["estado"],
      );

  toJson() {}
}

class AvailableMonitor {
  AvailableMonitor({
    required this.id,
    required this.user,
    required this.porcentajes,
    required this.carrera,
    required this.descripcion,
    required this.monitoriasCount,
  });

  final int id;
  final MonitorUser user;
  final List<MonitorMonitoria> porcentajes;
  final String carrera;
  final String descripcion;
  final int monitoriasCount;

  factory AvailableMonitor.fromMap(Map<String, dynamic> json) =>
      AvailableMonitor(
        id: json["id"],
        user: MonitorUser.fromMap(json["user"]),
        porcentajes: List<MonitorMonitoria>.from(
            json["porcentajes"].map((x) => MonitorMonitoria.fromMap(x))),
        carrera: json["carrera"],
        descripcion: json["descripcion"],
        monitoriasCount: json["monitorias_count"],
      );
}

class MonitorMonitoria {
  MonitorMonitoria({
    required this.id,
    required this.porcentaje,
    required this.monitor,
    required this.materia,
  });

  final int id;
  final int porcentaje;
  final AvailableMonitor? monitor;
  final Materia materia;

  factory MonitorMonitoria.fromMap(Map<String, dynamic> json) =>
      MonitorMonitoria(
        id: json["id"],
        porcentaje: json["porcentaje"],
        monitor: json["monitor"] == null
            ? null
            : AvailableMonitor.fromMap(json["monitor"]),
        materia: Materia.fromMap(json["materia"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "porcentaje": porcentaje,
        "materia": materia.toMap(),
      };
}

class MonitorUser {
  MonitorUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.cedula,
    required this.imagen,
    required this.entidad,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String cedula;
  final String imagen;
  final Entidad? entidad;

  factory MonitorUser.fromMap(Map<String, dynamic> json) => MonitorUser(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        cedula: json["cedula"],
        imagen: json["imagen"],
        entidad:
            json["entidad"] == null ? null : Entidad.fromMap(json["entidad"]),
      );
}

class Entidad {
  Entidad({
    required this.id,
    required this.nombre,
    required this.ciudad,
    required this.direccion,
    required this.tipo,
  });

  final int id;
  final String nombre;
  final String ciudad;
  final String direccion;
  final String tipo;

  factory Entidad.fromMap(Map<String, dynamic> json) => Entidad(
        id: json["id"],
        nombre: json["nombre"],
        ciudad: json["ciudad"],
        direccion: json["direccion"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "ciudad": ciudad,
        "direccion": direccion,
        "tipo": tipo,
      };
}

class Materia {
  Materia({
    required this.id,
    required this.nombre,
  });

  final int id;
  final String nombre;

  factory Materia.fromMap(Map<String, dynamic> json) => Materia(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
