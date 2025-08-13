import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/src/ui/pages/configuracion/configuracion_page.dart';
import 'package:tasks/src/ui/pages/dashboard/content_controller.dart';
import 'package:tasks/src/ui/pages/inicio/inicio_page.dart';
import 'package:tasks/src/ui/pages/tarea/tarea_page.dart';
import 'package:tasks/src/ui/pages/usuario/usuario_page.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});

  final ContentController controller = ContentController();
  final List<Widget> pages = [
    InicioPage(),
    TareaPage(),
    UsuarioPage(),
    ConfiguracionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentController>(
      init: controller,
      builder: (controller) => Scaffold(
        backgroundColor: Color.fromARGB(255, 209, 238, 244),
        body: PageView(
          controller: controller.pageController,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.indexPage,
            onTap: controller.onTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Tareas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Usuarios',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Configuracion',
              ),
            ],
            type: BottomNavigationBarType.fixed),
      ),
    );
  }
}
