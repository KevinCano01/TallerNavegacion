import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';
import 'package:hola_mundo/views/contador.dart';
import 'package:hola_mundo/services/auth_service.dart';
import 'package:hola_mundo/models/user.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final loadedUser = await AuthService().getUser();
    setState(() {
      user = loadedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'UCEVA',
      initialIndex: 0,
      length: 1,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido a la pantalla de inicio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (user != null) ...[
              Text(' Nombre: ${user!.name}'),
              Text(' Correo: ${user!.email}'),
            ] else
              const CircularProgressIndicator(),
            const SizedBox(height: 24),
            const Contador(),
          ],
        ),
      ),
    );
  }
}
