import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/ui/pages/configuracion/configuracion_controller.dart';
import 'package:tasks/src/ui/widget/app_bar_widget.dart';

class ConfiguracionPage extends StatelessWidget {
  ConfiguracionPage({super.key});
  final ConfiguracionController controller = ConfiguracionController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfiguracionController>(
        init: controller,
        builder: (controller) => Scaffold(
              appBar: appBarWidget(titulo: 'Configuración'),
              body: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Cerrar Sesion'),
                    onTap: controller.cerrarSesion,
                  )
                ],
              ),
            ));
  }
}
