import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';
import 'package:hola_mundo/views/contador.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'UCEVA', // Título de la pantalla
      body: Column(
        children: [
          const Center(child: Text('Bienvenido a la pantalla de inicio')),
          Contador(),
        ],
      ),
      //
    );
  }
}
