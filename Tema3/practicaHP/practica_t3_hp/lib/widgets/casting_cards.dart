import 'package:flutter/material.dart';
import 'package:practica_t3_hp/models/meal_receta.dart';
import 'package:practica_t3_hp/models/models.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:provider/provider.dart';
class IngredientsCards extends StatelessWidget {
  final MealReceta receta;

  const IngredientsCards({super.key, required this.receta});

  @override
  Widget build(BuildContext context) {
    // Obtener la lista de ingredientes de la receta
    final ingredients = receta.getIngredients();

    // Si no hay ingredientes, mostramos un mensaje
    if (ingredients.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            'No hay ingredientes disponibles.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    // Crear un ListView horizontal para mostrar los ingredientes
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      child: ListView.builder(
        itemCount: ingredients.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final ingredient = ingredients[index];
          final imageUrl =
              'https://www.themealdb.com/images/ingredients/$ingredient.png';
          return _IngredientCard(ingredient, imageUrl);
        },
      ),
    );
  }
}

class _IngredientCard extends StatelessWidget {
  final String ingredient;
  final String imageUrl;

  const _IngredientCard(this.ingredient, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(imageUrl),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            ingredient,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
