class SignUpRequest {
  int? id;
  String nombre;
  String apellido;
  String correo;
  String contrasena;
  String repetirContrasena;

  SignUpRequest({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.contrasena,
    required this.repetirContrasena,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      correo: json['correo'],
      contrasena: json['contrasena'],
      repetirContrasena: json['repetirContrasena']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'contrasena': contrasena,
        'repetirContrasena': repetirContrasena,
      };
}
