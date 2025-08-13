import 'dart:convert';

import 'package:get/get.dart';
import 'package:tasks/src/data/requests/sign_up_request.dart';
import 'package:tasks/src/models/user_model.dart';
import 'package:tasks/src/services/app_http_manager.dart';
import 'package:tasks/src/services/app_response.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

class AddUsuarioController extends GetxController {
  UsuarioModel? usuarioSeleccionado;

  String nombre = "";
  String apellido = "";
  String correo = "";
  String contrasena = "";
  String repetirContrasena = "";
  bool editando = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['selected'] != null) {
        usuarioSeleccionado = Get.arguments['selected'];
        editando = true;
        nombre = usuarioSeleccionado?.nombre ?? '';
        apellido = usuarioSeleccionado?.apellido ?? '';
        correo = usuarioSeleccionado?.correo ?? '';
        contrasena = usuarioSeleccionado?.contrasena ?? '';
      }
    }
    super.onInit();
  }

  String? validar() {
    if (nombre.trim().isEmpty) return 'Nombre no debe ser vacio';
    if (apellido.trim().isEmpty) return 'Apellido no debe ser vacio';
    if (correo.trim().isEmpty) return 'Correo no debe ser vacio';
    if (contrasena.trim().isEmpty) return 'Contraseña no debe ser vacio';
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

  Future<void> agregarUsuario() async {
    String? mensaje = validar();
    if (mensaje != null) {
      showSnackbar(mensaje);
      return;
    } else {
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
        UsuarioModel usuarioModel =
            UsuarioModel.fromJson(jsonDecode(response.body));
        Get.back(result: usuarioModel);
      } else {
        showSnackbar('Ocurrio un error con el servidor');
      }
    }
  }

  Future<void> edit() async {
    String? mensaje = validar();
    if (mensaje != null) {
      showSnackbar(mensaje);
      return;
    } else {
      AppHttpManager appHttpManager = AppHttpManager();
      showLoading();
      SignUpRequest signUpRequest = SignUpRequest(
          id: usuarioSeleccionado?.id,
          nombre: nombre,
          apellido: apellido,
          correo: correo,
          contrasena: contrasena,
          repetirContrasena: repetirContrasena);
      AppResponse response = await appHttpManager.put(
        path: '/usuario/update',
        body: signUpRequest.toJson(),
      );
      hideLoading();
      if (response.isSuccess) {
        UsuarioModel usuarioModel =
            UsuarioModel.fromJson(jsonDecode(response.body));
        Get.back(result: usuarioModel);
      } else {
        showSnackbar('Ocurrio un error con el servidor');
      }
    }
  }

  void showSnackbar(String message) {
    Get.snackbar('Error', message);
  }
}
