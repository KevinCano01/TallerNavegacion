import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Menú',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              context.go('/');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              context.go('/settings');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              context.go('/profile');
              Navigator.pop(context);
            },
          ),
          //! PASO DE PARÁMETROS
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Paso de Parámetros'),
            onTap: () {
              context.go('/paso_parametros');
              Navigator.pop(context);
            },
          ),
          //! CICLO DE VIDA
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              context.go('/ciclo_vida');
              Navigator.pop(context);
            },
          ),
          const Divider(),
          //! TALLER ASYNC - Lista de Estudiantes
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Lista de Estudiantes'),
            onTap: () {
              context.go('/lista_estudiantes');
              Navigator.pop(context);
            },
          ),
          //! TALLER ASYNC - Contador con Timer
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Timer'),
            onTap: () {
              context.go('/contador');
              Navigator.pop(context);
            },
          ),
          //! TALLER ASYNC - Tarea Pesada (Isolate)
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Tarea Pesada'),
            onTap: () {
              context.go('/tarea_pesada');
              Navigator.pop(context);
            },
          ),
          //! TALLER API - Listado de Comidas
          ListTile(
            leading: const Icon(Icons.fastfood),
            title: const Text('Listado de Comidas'),
            onTap: () {
              context.go('/listado');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
