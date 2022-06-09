class Request {
  Request({
    required this.id,
    required this.materia,
    required this.fecha,
    required this.fin,
  });

  final int id;
  final Materia materia;
  final DateTime fecha;
  final String fin;

  factory Request.fromMap(Map<String, dynamic> json) => Request(
        id: json["id"],
        materia: Materia.fromMap(json["materia"]),
        fecha: DateTime.parse(json["fecha"]),
        fin: json["fin"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "materia": materia.toMap(),
        "fecha": fecha.toIso8601String(),
        "fin": fin,
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
