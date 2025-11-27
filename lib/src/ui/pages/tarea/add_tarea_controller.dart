import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tasks/src/data/requests/tarea_request.dart';
import 'package:tasks/src/models/tarea_model.dart';
import 'package:tasks/src/services/app_http_manager.dart';
import 'package:tasks/src/services/app_response.dart';
import 'package:tasks/src/services/method_enum.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

class AddTareaController extends GetxController {
  TareaModel? tareaSeleccionada;

  String nombre = "";
  String descripcion = "";
  bool editando = false;
  String? pathSelected;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['selected'] != null) {
        tareaSeleccionada = Get.arguments['selected'];
        editando = true;
        nombre = tareaSeleccionada?.nombre ?? '';
        descripcion = tareaSeleccionada?.descripcion ?? '';
      }
    }
    super.onInit();
  }

  String? validar() {
    if (nombre.trim().isEmpty) return 'Nombre no debe ser vacio';
    if (descripcion.trim().isEmpty) return ' Descripcion no debe ser vacio';
    return null;
  }

  void onChangedNombre(String value) {
    nombre = value;
  }

  void onChangedDescripcion(String value) {
    descripcion = value;
  }

  Future<void> agregarTarea() async {
    String? mensaje = validar();
    if (mensaje != null) {
      showSnackbar(mensaje);
      return;
    } else {
      AppHttpManager appHttpManager = AppHttpManager();
      appHttpManager.get(path: '', headers: {'especial': '989743471'});
      showLoading();
      TareaRequest tareaRequest = TareaRequest(
        nombre: nombre,
        descripcion: descripcion,
      );
      AppResponse response = await appHttpManager.post(
          path: '/tarea/create', body: tareaRequest.toJson());
      hideLoading();
      if (response.isSuccess) {
        TareaModel tareaModel = TareaModel.fromJson(jsonDecode(response.body));
        Get.back(result: tareaModel);
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
      TareaRequest tareaRequest = TareaRequest(
        id: tareaSeleccionada?.id,
        nombre: nombre,
        descripcion: descripcion,
      );
      AppResponse response = await appHttpManager.put(
        path: '/tarea/update',
        body: tareaRequest.toJson(),
      );
      hideLoading();
      if (response.isSuccess) {
        TareaModel tareaModel = TareaModel.fromJson(jsonDecode(response.body));
        Get.back(result: tareaModel);
      } else {
        showSnackbar('Ocurrio un error con el servidor');
      }
    }
  }

  void showSnackbar(String message) {
    Get.snackbar('Error', message);
  }

  void picker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,

      // allowedExtensions: ['webp']
    );

    if (result != null) {
      pathSelected = result.files.single.path!;
      update();
    } else {
      // User canceled the picker
    }
  }

  void sendToServer() async {
    AppHttpManager appHttpManager = AppHttpManager();

    Map<String, String> body = {
      'nombre': nombre,
      'descripcion': descripcion,
    };

    AppResponse response = await appHttpManager.sendFile(
      method: MethodEnum.post,
      path: '/tarea/createAll',
      fieldNameOfFile: 'image',
      pathFile: pathSelected!,
      fields: body,
    );
    if (response.isSuccess) {
    } else {}
    /* http.MultipartRequest request = http.MultipartRequest(
        "POST", Uri.parse('http://10.0.2.2:3000/tarea/createAll'));
    request.fields['nombre'] = nombre;
    request.fields['descripcion'] = descripcion;
    http.MultipartFile file =
        await http.MultipartFile.fromPath('image', pathSelected!);
    request.files.add(file);
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });*/
  }
}
