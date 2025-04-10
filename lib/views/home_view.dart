import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';
import 'package:hola_mundo/views/contador.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'UCEVA',
      initialIndex: 0, // ← ahora se pasa correctamente
      length: 1, // ← también requerido por BaseView
      body: Column(
        children: [
          const Center(child: Text('Bienvenido a la pantalla de inicio')),
          Contador(),
        ],
      ),
    );
  }
}
