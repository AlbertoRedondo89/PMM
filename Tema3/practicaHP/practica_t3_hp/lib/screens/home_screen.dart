import 'package:flutter/material.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:practica_t3_hp/providers/movies_provider.dart';
import 'package:practica_t3_hp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealsProvider>(context, listen: true);
    print('iniciando');

    print(mealsProvider.mealsDePrueba.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comiditas'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(meals: mealsProvider.mealsDePrueba),

              // Slider de pel·licules
              MealSlider(meals: mealsProvider.mealsDePrueba),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
