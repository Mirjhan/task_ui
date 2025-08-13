import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              appBar: appBarWidget(titulo: 'Crear nuevo Usuario'),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      InputWidget(
                          hintText: 'Nombre', prefixIconData: Icons.abc),
                      InputWidget(
                          hintText: 'Apellido', prefixIconData: Icons.abc),
                      InputWidget(
                          hintText: 'Correo', prefixIconData: Icons.email),
                      InputWidget(
                          hintText: 'Contraseña', prefixIconData: Icons.lock)
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
}
