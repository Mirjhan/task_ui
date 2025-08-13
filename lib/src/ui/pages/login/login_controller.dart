import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/src/data/requests/login_request.dart';
import 'package:tasks/src/models/user_model.dart';
import 'package:tasks/src/models/user_preferences.dart';
import 'package:tasks/src/services/app_http_manager.dart';
import 'package:tasks/src/services/app_response.dart';
import 'package:tasks/src/ui/pages/dashboard/content_page.dart';
import 'package:tasks/src/ui/pages/sign_up/sign_up_page.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

class LoginController extends GetxController {
  String correo = "";
  String contrasena = "";

  @override
  void onInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('estaLogeado') ?? false) {
      Get.off(() => ContentPage());
    }
    super.onInit();
  }

  String? validar() {
    if (correo.trim().isEmpty) return "Correo no debe ser un campo vacío";
    if (contrasena.trim().isEmpty) return "Contraseña no debe ser campo vacío";
    return null;
  }

  Future<void> enviar() async {
    String? mensaje = validar();
    if (mensaje != null) {
      showSnackbar(mensaje);
      return;
    }
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    LoginRequest loginRequest = LoginRequest(
      correo: correo,
      contrasena: contrasena,
    );
    AppResponse response = await appHttpManager.post(
        path: '/auth/login', body: loginRequest.toJson());
    hideLoading();
    if (response.isSuccess) {
      UsuarioModel.fromJson(jsonDecode(response.body));
      UserPreferences().prefs?.setBool('estaLogeado', true);
      Get.off(() => ContentPage());
    } else {
      showSnackbar('Ocurrio un error con el servidor');
    }
  }

  void goToSignUp() {
    Get.to(() => SignUpPage());
  }

  void showSnackbar(String message) {
    Get.snackbar('Error', message);
  }
}
