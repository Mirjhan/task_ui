import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/ui/pages/tarea/add_tarea_controller.dart';
import 'package:tasks/src/ui/widget/app_bar_widget.dart';
import 'package:tasks/src/ui/widget/button_widget.dart';
import 'package:tasks/src/ui/widget/input_widget.dart';

class AddTareaPage extends StatelessWidget {
  AddTareaPage({super.key});
  final AddTareaController controller = AddTareaController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTareaController>(
      init: controller,
      builder: (controller) => Stack(
        children: [
          Scaffold(
              appBar: appBarWidget(titulo: 'Crear nueva tarea'),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      InputWidget(
                        hintText: 'Nombre',
                        prefixIconData: Icons.abc,
                        onChanged: controller.onChangedNombre,
                        initialValue: controller.tareaSeleccionada?.nombre,
                      ),
                      InputWidget(
                        hintText: 'Descripcion',
                        prefixIconData: Icons.abc,
                        onChanged: controller.onChangedDescripcion,
                        initialValue: controller.tareaSeleccionada?.descripcion,
                      ),
                      GestureDetector(
                          onTap: controller.picker, child: showImage())
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ButtonWidget(
                title: controller.editando ? 'Guardar' : 'Agregar',
                onTap: controller.editando
                    ? controller.edit
                    : controller.agregarTarea,
              )),
        ],
      ),
    );
  }

  Image showImage() => (controller.pathSelected != null)
      ? Image.file(File(controller.pathSelected!))
      : Image.asset('assets/images/camara.jpg');
}
