import 'package:flutter/material.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:practica_t3_hp/widgets/search_dialog.dart';
import 'package:practica_t3_hp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealsProvider>(context, listen: true);
     // Lista de categorías
    // Lista de categorías con sus imágenes
    final categories = [
      {
        'name': 'Beef',
        'icon': 'https://www.themealdb.com/images/category/beef.png',
      },
      {
        'name': 'Chicken',
        'icon': 'https://www.themealdb.com/images/category/chicken.png',
      },
      {
        'name': 'Dessert',
        'icon': 'https://www.themealdb.com/images/category/dessert.png',
      },
      {
        'name': 'Lamb',
        'icon': 'https://www.themealdb.com/images/category/lamb.png',
      },
      {
        'name': 'Miscellaneous',
        'icon': 'https://www.themealdb.com/images/category/miscellaneous.png',
      },
      {
        'name': 'Pasta',
        'icon': 'https://www.themealdb.com/images/category/pasta.png',
      },
      {
        'name': 'Pork',
        'icon': 'https://www.themealdb.com/images/category/pork.png',
      },
      {
        'name': 'Seafood',
        'icon': 'https://www.themealdb.com/images/category/seafood.png',
      },
      {
        'name': 'Side',
        'icon': 'https://www.themealdb.com/images/category/side.png',
      },
      {
        'name': 'Starter',
        'icon': 'https://www.themealdb.com/images/category/starter.png',
      },
      {
        'name': 'Vegan',
        'icon': 'https://www.themealdb.com/images/category/vegan.png',
      },
      {
        'name': 'Vegetarian',
        'icon': 'https://www.themealdb.com/images/category/vegetarian.png',
      },
      {
        'name': 'Breakfast',
        'icon': 'https://www.themealdb.com/images/category/breakfast.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comiditas'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showSearchDialog(context),
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
                          const SizedBox(height: 20,),
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
            ),
            const SizedBox(height: 20),
            // Targetes principals
            CardSwiper(meals: mealsProvider.mealsPrincipales),

            // Slider de recetas sugeridas
            MealSlider(mealsAlAzar: mealsProvider.mealsSugeridos),
          ],
        ),
      ),
    );
  }
  
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SearchDialog();
      },
    );
  }
}
