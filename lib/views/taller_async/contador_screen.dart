import 'dart:async';
import 'package:flutter/material.dart';

class ContadorScreen extends StatefulWidget {
  const ContadorScreen({super.key});

  @override
  State<ContadorScreen> createState() => _ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen> {
  int _contador = 0;
  Timer? _timer;

  void _iniciar() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _contador++);
    });
  }

  void _pausar() {
    _timer?.cancel();
  }

  void _reiniciar() {
    _pausar();
    setState(() => _contador = 0);
    _iniciar();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $_contador', style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _iniciar,
                  child: const Text('Iniciar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _pausar, child: const Text('Pausar')),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _reiniciar,
                  child: const Text('Reiniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
