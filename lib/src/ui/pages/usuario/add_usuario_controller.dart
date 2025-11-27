import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tasks/src/data/requests/sign_up_request.dart';
import 'package:tasks/src/models/user_model.dart';
import 'package:tasks/src/services/app_http_manager.dart';
import 'package:tasks/src/services/app_response.dart';
import 'package:tasks/src/services/method_enum.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

class AddUsuarioController extends GetxController {
  UsuarioModel? usuarioSeleccionado;

  String nombre = "";
  String apellido = "";
  String correo = "";
  String contrasena = "";
  String repetirContrasena = "";
  bool editando = false;
  String? pathSelected;

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
      SignUpRequest signUpRequest = SignUpRequest(
          id: usuarioSeleccionado?.id,
          nombre: nombre,
          apellido: apellido,
          correo: correo,
          contrasena: contrasena,
          repetirContrasena: repetirContrasena);
      showLoading();
      AppResponse response = await appHttpManager.put(
        path: '/usuario/update',
        body: signUpRequest.toJson(),
      );
      hideLoading();
      if (response.isSuccess) {
        UsuarioModel usuarioModel =
            UsuarioModel.fromJson(jsonDecode(response.body));
        await actualizarImagen();

        // aqui debes actualizar la image
        Get.back(result: usuarioModel);
      } else {
        showSnackbar('Ocurrio un error con el servidor');
      }
    }
  }

  Future<void> actualizarImagen() async {
    if (usuarioSeleccionado == null) return;
    int id = usuarioSeleccionado!.id;
    AppHttpManager appHttpManager = AppHttpManager();
    Map<String, String> body = {
      'id': id.toString(),
    };
    AppResponse response = await appHttpManager.sendFile(
      method: MethodEnum.put,
      path: '/usuario/updateImage',
      fieldNameOfFile: 'avatar',
      pathFile: pathSelected!,
      fields: body,
    );
    if (response.isSuccess) {}
    // armar tu peticion de MULTPARTFILE -> apphttpmanager
    // {id: id}
    // si ocurre un error lo dices
    // si no no haces nada
  }

  void showSnackbar(String message) {
    Get.snackbar('Error', message);
  }

  void picker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      pathSelected = result.files.single.path!;
      update();
    }
  }

  void sendToServer() async {
    AppHttpManager appHttpManager = AppHttpManager();
    Map<String, String> body = {
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'contrasena': contrasena,
      'repetirContrasena': repetirContrasena,
    };

    AppResponse response = await appHttpManager.sendFile(
        method: MethodEnum.post,
        path: '/usuario/createAll',
        fieldNameOfFile: 'avatar',
        pathFile: pathSelected!,
        fields: body);
    if (response.isSuccess) {}
  }
}
