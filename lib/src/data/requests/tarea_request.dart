class TareaRequest {
  int? id;
  String nombre;
  String descripcion;

  TareaRequest({
    this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory TareaRequest.fromJson(Map<String, dynamic> json) => TareaRequest(
        id: json['id'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
      };
}
