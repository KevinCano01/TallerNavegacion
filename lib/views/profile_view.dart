import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Perfil',
      initialIndex:
          1, // ← Este índice representa la posición del perfil en el menú
      length: 1,
      body: const Center(child: Text('Pantalla de perfil')),
    );
  }
}
