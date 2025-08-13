import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/ui/core/colors.dart';
import 'package:tasks/src/ui/pages/usuario/usuario_controller.dart';
import 'package:tasks/src/ui/widget/app_bar_widget.dart';

class UsuarioPage extends StatelessWidget {
  UsuarioPage({super.key});
  final UsuarioController controller = UsuarioController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(titulo: 'Usuarios'),
        body: RefreshIndicator(
            onRefresh: controller.getUsuarios,
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: controller.usuarios.length,
                itemBuilder: (context, index) => itemListTile(
                    controller.usuarios[index].nombre,
                    controller.usuarios[index].correo,
                    index))),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goToAddUsuarioPage,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget itemListTile(String title, String subtitle, int posicion) {
    return Container(
      padding: EdgeInsets.all(15),
      child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: darkPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
          ),
          trailing: SizedBox(
            width: 96,
            child: Row(
              children: [
                IconButton(
                    onPressed: () => controller.goEditarUsuarioPage(posicion),
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () => controller.goEliminarUsuario(posicion),
                    icon: Icon(Icons.delete)),
              ],
            ),
          )),
    );
  }
}
