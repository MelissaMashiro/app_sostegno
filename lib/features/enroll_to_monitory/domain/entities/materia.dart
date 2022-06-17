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
    required this.codigo,
    required this.id,
    required this.nombre,
  });

  final String codigo;
  final int id;
  final String nombre;

  factory MateriaDetail.fromMap(Map<String, dynamic> json) => MateriaDetail(
        codigo: json["codigo"],
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "id": id,
        "nombre": nombre,
      };
}
