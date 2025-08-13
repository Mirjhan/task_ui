// To parse this JSON data, do
//
//     final tareaModel = tareaModelFromJson(jsonString);

import 'dart:convert';

List<TareaModel> tareaModelFromJson(String str) =>
    List<TareaModel>.from(json.decode(str).map((x) => TareaModel.fromJson(x)));

String tareaModelToJson(List<TareaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TareaModel {
  int id;
  String nombre;
  String descripcion;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  TareaModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory TareaModel.fromJson(Map<String, dynamic> json) => TareaModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
