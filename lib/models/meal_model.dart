// Modelo de datos para manejar la respuesta de la API The Meal DB

class Meal {
  final String id;
  final String name;
  final String? category;
  final String? area;
  final String? instructions;
  final String? imageUrl;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.name,
    this.category,
    this.area,
    this.instructions,
    this.imageUrl,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? 'Desconocido',
      category: json['strCategory'] ?? 'Sin categoría',
      area: json['strArea'] ?? 'Desconocido',
      instructions: json['strInstructions'] ?? 'Sin instrucciones',
      imageUrl: json['strMealThumb'] ?? '',
      ingredients: ingredients,
    );
  }
}
