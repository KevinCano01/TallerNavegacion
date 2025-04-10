import 'package:flutter/material.dart';

class ListaEstudiantesScreen extends StatefulWidget {
  const ListaEstudiantesScreen({super.key});

  @override
  State<ListaEstudiantesScreen> createState() => _ListaEstudiantesScreenState();
}

class _ListaEstudiantesScreenState extends State<ListaEstudiantesScreen> {
  List<String> _nombres = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerDatos();
  }

  Future<void> obtenerDatos() async {
    await Future.delayed(const Duration(seconds: 2));
    final datos = ['Kevin', 'Firulais', 'Pancracio', 'Rigoberto', 'Elsapatito'];
    if (!mounted) return;
    setState(() {
      _nombres = datos;
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Estudiantes')),
      body:
          _cargando
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _nombres.length,
                itemBuilder:
                    (context, index) => ListTile(title: Text(_nombres[index])),
              ),
    );
  }
}
