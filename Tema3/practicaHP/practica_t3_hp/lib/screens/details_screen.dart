import 'package:flutter/material.dart';
import 'package:practica_t3_hp/models/models.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:practica_t3_hp/widgets/widgets.dart';
import 'package:provider/provider.dart';

/*
Recibe el id de una receta como parámetro. Hace una llamada a la API mediante el provider para obtener todos los datos.
Muestra todos los datos de la receta y, por último, usa el widget casting_cards para mostrar las imágenes de los ingredientes. 
*/

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String comida = ModalRoute.of(context)?.settings.arguments as String;
    final mealsProvider = Provider.of<MealsProvider>(context, listen: false);
    final Future<MealReceta?> comidilla = mealsProvider.getDatosReceta(comida, true);

    return Scaffold(
      body: FutureBuilder<MealReceta?>(
        future: comidilla,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('Meal not found.'),
            );
          }

          final receta = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.indigo,
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.all(0),
                  title: Container(
                    height: 40.0,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    color: Colors.black.withOpacity(0.3),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      receta.getTitulo(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  background: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: NetworkImage(receta.getImage()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _Overview(receta: receta),
                    IngredientsCards(receta: receta),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final MealReceta receta;

  const _Overview({super.key, required this.receta});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea los textos a la izquierda
        children: [
          const SizedBox(height: 20), // Espacio entre los textos
          const Text(
            'Ingredients:',
             style: TextStyle(
                color: Color.fromARGB(255, 90, 69, 5),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
          ),
          const SizedBox(height: 10),
          // Mostrar lista de ingredientes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: receta.getIngredientesDetalles().map((detalle) {
              return Text(
                detalle,
                style: Theme.of(context).textTheme.bodySmall,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Directions:',
                style: TextStyle(
                color: Color.fromARGB(255, 90, 69, 5),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
          ),
          const SizedBox(height: 10),
          Text(
            receta.getInstructions(),
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

