import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea', style: TextStyle(color: Colors.red)),
        centerTitle: true,
      ),
    );
  }
}
