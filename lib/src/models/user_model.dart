// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

List<UsuarioModel> usuarioModelFromJson(String str) => List<UsuarioModel>.from(
    json.decode(str).map((x) => UsuarioModel.fromJson(x)));

String usuarioModelToJson(List<UsuarioModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsuarioModel {
  int id;
  String nombre;
  String apellido;
  String correo;
  String contrasena;
  String? avatar;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.contrasena,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        contrasena: json["contrasena"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "contrasena": contrasena,
        "avatar": avatar,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
