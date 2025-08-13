import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  controller.tareas[index].nombre,
                  controller.tareas[index].descripcion,
                  index)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goToAddTareaPage,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget itemListTile(String title, String subtitle, int posicion) {
    return Container(
      padding: EdgeInsets.all(15),
      child: ListTile(
          leading: CircleAvatar(),
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
}
