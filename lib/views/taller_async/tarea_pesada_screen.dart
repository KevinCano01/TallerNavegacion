import 'dart:isolate';
import 'package:flutter/material.dart';

class TareaPesadaScreen extends StatefulWidget {
  const TareaPesadaScreen({super.key});

  @override
  State<TareaPesadaScreen> createState() => _TareaPesadaScreenState();
}

class _TareaPesadaScreenState extends State<TareaPesadaScreen> {
  bool _ejecutando = false;

  // Función que ejecuta la suma en un Isolate
  Future<void> ejecutarTareaPesada() async {
    if (_ejecutando) return;
    setState(() => _ejecutando = true);

    final receivePort = ReceivePort();

    // Lanzar isolate con el puerto
    await Isolate.spawn(sumarNumeros, receivePort.sendPort);

    // Esperar el resultado
    final resultado = await receivePort.first;

    if (!mounted) return;

    // Mostrar resultado con SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Resultado de la suma: $resultado'),
        duration: const Duration(seconds: 3),
      ),
    );

    setState(() => _ejecutando = false);
  }

  // Función estática que se ejecuta en el Isolate
  static void sumarNumeros(SendPort sendPort) {
    int suma = 0;
    for (int i = 1; i <= 2000000; i++) {
      suma += i;
    }
    sendPort.send(suma); // Enviar resultado de vuelta
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarea Pesada con Isolate')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_ejecutando)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: ejecutarTareaPesada,
                child: const Text('Ejecutar Tarea Pesada'),
              ),
          ],
        ),
      ),
    );
  }
}
