import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/models/tarea_model.dart';
import 'package:tasks/src/services/app_http_manager.dart';
import 'package:tasks/src/services/app_response.dart';
import 'package:tasks/src/ui/pages/tarea/add_tarea_page.dart';
import 'package:tasks/src/ui/widget/loading_service.dart';

class TareaController extends GetxController {
  List<TareaModel> tareas = [];

  @override
  void onReady() async {
    getTareas();
    super.onReady();
  }

  Future<void> getTareas() async {
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    AppResponse response = await appHttpManager.get(path: '/tarea/');
    hideLoading();
    if (response.isSuccess) {
      tareas.clear();
      tareas.addAll(tareaModelFromJson(response.body));
      update();
    } else {
      Get.snackbar('Error', 'Ocurrio un error');
    }
  }

  void goEditarTareaPage(int posicion) async {
    TareaModel selected = tareas[posicion];
    TareaModel? result =
        await Get.to<TareaModel>(() => AddTareaPage(), arguments: {
      'selected': selected,
    });
    if (result != null) {
      tareas[posicion] = result;
      Get.snackbar(
        'Exito',
        'Tarea editada',
        backgroundColor: Colors.cyan,
      );
    }
    update();
  }

  void goEliminarTarea(int posicion) async {
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
                    onPressed: () => Get.back(result: true), child: Text('Si'))
              ],
            ));
    if (response == true) {
      _eliminar(posicion);
    }
  }

  _eliminar(int posicion) async {
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    TareaModel selected = tareas[posicion];
    AppResponse response =
        await appHttpManager.delete(path: '/tarea/delete/${selected.id}');
    hideLoading();
    if (response.isSuccess) {
      tareas.removeAt(posicion);
      update();
    } else {
      Get.snackbar('Error', 'Ocurrio un error');
    }
  }

  Future<void> goToAddTareaPage() async {
    TareaModel? result = await Get.to<TareaModel>(() => AddTareaPage());
    if (result != null) {
      tareas.add(result);
      Get.snackbar('Exito', 'Tarea agregada');
      update();
    }
  }
}
