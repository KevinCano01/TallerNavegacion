import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetalleScreen extends StatelessWidget {
  final String parametro; // Parametro recibido desde la navegación
  final String metodoNavegacion; // El metodo de navegación (go, push, replace)

  // Recibimos los parámetros en el constructor
  const DetalleScreen({
    super.key,
    required this.parametro,
    required this.metodoNavegacion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de la opción')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parámetro recibido: $parametro', // Mostramos el parámetro recibido
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Método de navegación: $metodoNavegacion', // Mostramos el método de navegación
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20), // Espaciado entre elementos

            ElevatedButton(
              onPressed: () => context.pop(), // Volver atrás
              child: const Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
