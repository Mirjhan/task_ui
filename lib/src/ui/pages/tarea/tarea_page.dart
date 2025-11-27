import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/core/config.dart';
import 'package:tasks/src/ui/core/colors.dart';
import 'package:tasks/src/ui/pages/tarea/tarea_controller.dart';
import 'package:tasks/src/ui/widget/app_bar_widget.dart';

class TareaPage extends StatelessWidget {
  final TareaController controller = TareaController();
  TareaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TareaController>(
      init: controller,
      builder: (controller) => Scaffold(
        appBar: appBarWidget(titulo: 'Tareas'),
        body: RefreshIndicator(
          onRefresh: controller.getTareas,
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: controller.tareas.length,
              itemBuilder: (context, index) => itemListTile(
                  image: controller.tareas[index].imagen,
                  title: controller.tareas[index].nombre,
                  subtitle: controller.tareas[index].descripcion,
                  posicion: index)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goToAddTareaPage,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget itemListTile({
    required String title,
    required String subtitle,
    required int posicion,
    String? image,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      child: ListTile(
          leading: CircleAvatar(
            backgroundImage: _pickImage(image),
          ),
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
                    onPressed: () => controller.goEditarTareaPage(posicion),
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () => controller.goEliminarTarea(posicion),
                    icon: Icon(Icons.delete)),
              ],
            ),
          )),
    );
  }

  ImageProvider _pickImage(String? image) {
    return (image != null)
        ? NetworkImage('$urlServer/tarea/$image')
        : AssetImage('assets/images/notfound.png');
  }
}
