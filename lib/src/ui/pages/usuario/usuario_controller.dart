import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/models/user_model.dart';
import 'package:tasks/src/services/app_http_manager.dart';
import 'package:tasks/src/services/app_response.dart';
import 'package:tasks/src/ui/pages/usuario/add_usuario_page.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

class UsuarioController extends GetxController {
  List<UsuarioModel> usuarios = [];

  @override
  void onReady() async {
    getUsuarios();
    super.onReady();
  }

  Future<void> getUsuarios() async {
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    AppResponse response = await appHttpManager.get(path: '/usuario/');
    hideLoading();
    if (response.isSuccess) {
      usuarios = usuarioModelFromJson(response.body);
      update();
    } else {
      Get.snackbar('Error', 'Ocurrio un error');
    }
  }

  void goEditarUsuarioPage(int posicion) async {
    UsuarioModel selected = usuarios[posicion];
    UsuarioModel? result =
        await Get.to<UsuarioModel>(() => AddUsuarioPage(), arguments: {
      'selected': selected,
    });
    if (result != null) {
      usuarios[posicion] = result;
      Get.snackbar('Exito', 'Usuario editado', backgroundColor: Colors.cyan);
    }
    update();
  }

  void goEliminarUsuario(int posicion) async {
    bool response = await showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
              title: Text('Alerta'),
              content: Text('Estás seguro de eliminar la tarea $posicion?'),
              actions: [
                TextButton(
                    onPressed: () => Get.back(result: false),
                    child: Text('No')),
                TextButton(
                    onPressed: () => Get.back(result: true), child: Text('Si')),
              ],
            ));
    if (response == true) {
      _eliminar(posicion);
    }
  }

  _eliminar(int posicion) async {
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    UsuarioModel selected = usuarios[posicion];
    AppResponse response =
        await appHttpManager.delete(path: '/usuarios/delete/${selected.id}');
    hideLoading();
    if (response.isSuccess) {
      usuarios.removeAt(posicion);
      update();
    } else {
      Get.snackbar('Error', 'Ocurrio un error');
    }
  }

  Future<void> goToAddUsuarioPage() async {
    UsuarioModel? result = await Get.to<UsuarioModel>(() => AddUsuarioPage());
    if (result != null) {
      usuarios.add(result);
      Get.snackbar('Exito', 'Usuario agregado');
      update();
    }
  }
}
