import 'dart:convert';
import 'package:hola_mundo/models/meal_model.dart';
import 'package:http/http.dart' as http;

// Servicio para consumir la API de The Meal DB

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Meal>> fetchMeals() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/search.php?s='));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List meals = data['meals'];
        return meals.map((meal) => Meal.fromJson(meal)).toList();
      } else {
        throw Exception('Error al obtener los datos de la API');
      }
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }

  Future<Meal> fetchMealDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List meals = data['meals'];
        return Meal.fromJson(meals.first);
      } else {
        throw Exception('Error al obtener el detalle de la comida');
      }
    } catch (e) {
      throw Exception('Error al conectar con la API: $e');
    }
  }
}
