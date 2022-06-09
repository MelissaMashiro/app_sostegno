import 'dart:convert';

import 'package:app_sostegno/features/enroll_to_monitory/data/models/available_monitory.dart';

class UserEntity {
  UserEntity({
    required this.person,
    required this.personType,
    required this.accessToken,
  });

  final Person person;
  final int personType;
  final String accessToken;

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        person: Person.fromMap(json["person"]),
        personType: json["personType"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toMap() => {
        "person": person.toMap(),
        "personType": personType,
        "accessToken": accessToken,
      };

  String toJson() => json.encode(toMap());
}

class Person {
  Person({
    required this.id,
    required this.user,
    this.porcentajes,
    this.carrera,
    this.descripcion,
    this.monitoriasCount,
  });

  final int id;
  final User user;
  final List<MonitorMonitoria>? porcentajes;
  final String? carrera;
  final String? descripcion;
  final int? monitoriasCount;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        id: json["id"],
        user: User.fromMap(json["user"]),
        porcentajes: json['porcentajes'] != null
            ? List<MonitorMonitoria>.from(
                json["porcentajes"].map((x) => MonitorMonitoria.fromMap(x)))
            : null,
        carrera: json['carrera'] != null ? json["carrera"] : null,
        descripcion: json['descripcion'] != null ? json["descripcion"] : null,
        monitoriasCount:
            json['monitorias_count'] != null ? json["monitorias_count"] : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user": user.toMap(),
        "porcentajes": porcentajes != null
            ? List<dynamic>.from(porcentajes!.map((x) => x.toMap()))
            : [],
        "carrera": carrera,
        "descripcion": descripcion,
        "monitorias_count": monitoriasCount,
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

class User {
  User({
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
  final Entidad entidad;

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        cedula: json["cedula"],
        imagen: json["imagen"],
        entidad: Entidad.fromMap(json["entidad"]),
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "cedula": cedula,
        "imagen": imagen,
        "entidad": entidad.toMap(),
      };
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
