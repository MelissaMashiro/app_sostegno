class University {
  University({
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

  factory University.fromMap(Map<String, dynamic> json) => University(
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
