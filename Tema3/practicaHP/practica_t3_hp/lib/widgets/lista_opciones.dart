import 'package:flutter/material.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';

class ListaOpciones extends StatelessWidget {
  const ListaOpciones({
    super.key,
    required this.categories,
    required this.mealsProvider,
  });

  final List<Map<String, String>> categories;
  final MealsProvider mealsProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Aumenta la altura para acomodar los iconos
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                mealsProvider.setMealsPrincipales(category['name']!);
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Icono de categoría
                  CircleAvatar(
                    backgroundImage: NetworkImage(category['icon']!),
                    radius: 30,
                  ),
                  const SizedBox(height: 5),
                  // Nombre de la categoría
                  Text(
                    category['name']!,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
