// Pantalla de detalle de la comida
import 'package:flutter/material.dart';
import '../../models/meal_model.dart';

class DetalleScreen extends StatelessWidget {
  final Meal meal;

  const DetalleScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        //  Envolvemos el contenido en un scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            meal.imageUrl != null
                ? Image.network(meal.imageUrl!)
                : const Icon(Icons.broken_image, size: 100),
            const SizedBox(height: 16),
            Text(
              meal.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Categoría: ${meal.category ?? 'No disponible'} | Área: ${meal.area ?? 'No disponible'}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              'Instrucciones:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(meal.instructions ?? 'No hay instrucciones disponibles'),
            const SizedBox(height: 16),
            Text(
              'Ingredientes:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...meal.ingredients
                .map((ingredient) => Text('- $ingredient'))
                .toList(),
          ],
        ),
      ),
    );
  }
}
