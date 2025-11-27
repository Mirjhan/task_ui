import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/core/config.dart';
import 'package:tasks/src/ui/pages/usuario/add_usuario_controller.dart';
import 'package:tasks/src/ui/widget/app_bar_widget.dart';
import 'package:tasks/src/ui/widget/button_widget.dart';
import 'package:tasks/src/ui/widget/input_widget.dart';

class AddUsuarioPage extends StatelessWidget {
  AddUsuarioPage({super.key});
  final AddUsuarioController controller = AddUsuarioController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUsuarioController>(
        init: controller,
        builder: (controller) => Scaffold(
              appBar: appBarWidget(
                  titulo: controller.editando
                      ? 'Editar Usuario'
                      : 'Crear nuevo Usuario'),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      InputWidget(
                        hintText: 'Nombre',
                        prefixIconData: Icons.abc,
                        onChanged: controller.onChangedNombre,
                        initialValue: controller.usuarioSeleccionado?.nombre,
                      ),
                      InputWidget(
                        hintText: 'Apellido',
                        prefixIconData: Icons.abc,
                        onChanged: controller.onChangedApellido,
                        initialValue: controller.usuarioSeleccionado?.apellido,
                      ),
                      InputWidget(
                        hintText: 'Correo',
                        prefixIconData: Icons.email,
                        onChanged: controller.onChangedCorreo,
                        initialValue: controller.usuarioSeleccionado?.correo,
                      ),
                      InputWidget(
                        hintText: 'Contraseña',
                        prefixIconData: Icons.lock,
                        onChanged: controller.onChangedContrasena,
                        initialValue:
                            controller.usuarioSeleccionado?.contrasena,
                      ),
                      GestureDetector(
                        onTap: controller.picker,
                        child: showImage(),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ButtonWidget(
                title: controller.editando ? 'Guardar' : 'Agregar',
                onTap: controller.editando
                    ? controller.edit
                    : controller.agregarUsuario,
              ),
            ));
  }

  Image showImage() {
    if (controller.pathSelected != null) {
      return Image.file(File(controller.pathSelected!));
    }
    return (controller.usuarioSeleccionado?.avatar == null)
        ? Image.asset('assets/images/camara.jpg')
        : Image.network(
            '$urlServer/usuario/${controller.usuarioSeleccionado?.avatar}');
  }
}
