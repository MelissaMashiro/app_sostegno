class CustomMateria {
  CustomMateria({
    required this.id,
    required this.porcentaje,
    required this.materia,
  });

  final int id;
  final int porcentaje;
  final MateriaDetail materia;

  factory CustomMateria.fromMap(Map<String, dynamic> json) => CustomMateria(
        id: json["id"],
        porcentaje: json["porcentaje"],
        materia: MateriaDetail.fromMap(json["materia"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "porcentaje": porcentaje,
        "materia": materia.toMap(),
      };
}

class MateriaDetail {
  MateriaDetail({
    required this.id,
    required this.nombre,
  });

  final int id;
  final String nombre;

  factory MateriaDetail.fromMap(Map<String, dynamic> json) => MateriaDetail(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
