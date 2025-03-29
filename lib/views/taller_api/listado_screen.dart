// Pantalla de listado de comidas
import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/meal_model.dart';
import 'detalle_screen.dart';

class ListadoScreen extends StatefulWidget {
  const ListadoScreen({super.key});

  @override
  _ListadoScreenState createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  late Future<List<Meal>> _meals;

  @override
  void initState() {
    super.initState();
    _meals = ApiService().fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado de Comidas')),
      body: FutureBuilder<List<Meal>>(
        future: _meals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final meal = snapshot.data![index];
                return ListTile(
                  leading:
                      meal.imageUrl != null
                          ? Image.network(meal.imageUrl!)
                          : const Icon(Icons.broken_image),
                  title: Text(meal.name),
                  subtitle: Text(meal.category ?? 'Categoría no disponible'),
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleScreen(meal: meal),
                        ),
                      ),
                );
              },
            );
          } else {
            return const Center(child: Text('No hay datos disponibles.'));
          }
        },
      ),
    );
  }
}
