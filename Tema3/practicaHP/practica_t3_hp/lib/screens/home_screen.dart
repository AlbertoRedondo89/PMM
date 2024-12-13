import 'package:flutter/material.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:practica_t3_hp/widgets/widgets.dart';
import 'package:provider/provider.dart';

/*
Pagina principal de la aplicación. 
En la parte superior hay botones para seleccionar una categoría. Al pulsarlos se actualiza en CardSwiper.
Debajo está el CardSwiper con una lista de recetas de una categoria concreta inicialmente, que se actualiza al elegir otra categoria.
Debajo, un MealSlider muestra diez recetas aleatorias. 
Al pulsar sobre cualquiera de ellas mostrará la receta completa en una detail_screen. 
*/

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
            //Opciones de categorias
            ListaOpciones(categories: categories, mealsProvider: mealsProvider),

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
