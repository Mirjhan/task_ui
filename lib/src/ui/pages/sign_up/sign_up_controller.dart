import 'dart:convert';
import 'package:get/get.dart';
import 'package:tasks/src/data/requests/sign_up_request.dart';
import 'package:tasks/src/models/user_model.dart';
import 'package:tasks/src/models/user_preferences.dart';
import 'package:tasks/src/services/app_http_manager.dart';
import 'package:tasks/src/services/app_response.dart';
import 'package:tasks/src/ui/pages/dashboard/content_page.dart';
import 'package:tasks/src/ui/pages/login/login_page.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

class SignUpController extends GetxController {
  String nombre = "";
  String apellido = "";
  String correo = "";
  String contrasena = "";
  String repetirContrasena = "";

  String? validar() {
    if (nombre.trim().isEmpty) return "Nombre no debe ser vacio";
    if (apellido.trim().isEmpty) return "Apellido no debe ser vacio";
    if (correo.trim().isEmpty) return "Correo no debe ser vacio";
    if (contrasena.trim().isEmpty) return "Contraseña no debe ser vacio";
    if (repetirContrasena.trim().isEmpty) return "Rep contr no debe ser vacio";
    if (contrasena != repetirContrasena) return "Contraseñas no coinciden";
    return null;
  }

  void onChangedNombre(String value) {
    nombre = value;
  }

  void onChangedApellido(String value) {
    apellido = value;
  }

  void onChangedCorreo(String value) {
    correo = value;
  }

  void onChangedContrasena(String value) {
    contrasena = value;
  }

  void onChangedRepetirContrasena(String value) {
    repetirContrasena = value;
  }

  Future<void> enviar() async {
    String? mensaje = validar();
    if (mensaje != null) {
      showSnackbar(mensaje);
      return;
    }
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    SignUpRequest signUpRequest = SignUpRequest(
        nombre: nombre,
        apellido: apellido,
        correo: correo,
        contrasena: contrasena,
        repetirContrasena: repetirContrasena);
    AppResponse response = await appHttpManager.post(
        path: '/usuario/create', body: signUpRequest.toJson());
    hideLoading();
    if (response.isSuccess) {
      UsuarioModel.fromJson(jsonDecode(response.body));
      UserPreferences().prefs?.setBool('estaLogeado', true);
      Get.off(() => ContentPage());
    } else {
      showSnackbar('Ocurrio un error en el servidor');
    }
  }

  void goToLoginPage() {
    Get.to(() => LoginPage());
  }

  void showSnackbar(String message) {
    Get.snackbar('Error', message);
  }
}
