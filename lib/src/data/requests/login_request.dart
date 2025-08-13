class LoginRequest {
  String correo = '';
  String contrasena = '';

  LoginRequest({
    required this.correo,
    required this.contrasena,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        correo: json['correo'],
        contrasena: json['contrasena'],
      );

  Map<String, dynamic> toJson() => {
        'correo': correo,
        'contrasena': contrasena,
      };
}
