import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Configuración',
      initialIndex: 2, // ← índice usado en el switch para /settings
      length: 1,
      body: const Center(child: Text('Pantalla de configuración')),
    );
  }
}
