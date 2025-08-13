import 'package:flutter/material.dart';
import 'package:tasks/src/ui/core/colors.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio',
          style: TextStyle(color: darkPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: Text('Holaaaa'),
    );
  }
}
