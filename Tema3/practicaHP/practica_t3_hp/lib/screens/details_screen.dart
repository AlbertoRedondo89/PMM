import 'package:flutter/material.dart';
import 'package:practica_t3_hp/models/meal_receta.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:practica_t3_hp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String comida = ModalRoute.of(context)?.settings.arguments as String;
    final mealsProvider = Provider.of<MealsProvider>(context, listen: false);
    final Future<MealReceta?> comidilla =
        mealsProvider.getDatosReceta(comida, true);

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
              child: Text('No se encontró la receta.'),
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
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    color: Colors.black12,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      receta.getTitulo(),
                      style: const TextStyle(fontSize: 16),
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

  const _Overview({Key? key, required this.receta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinea los textos a la izquierda
        children: [
          const SizedBox(height: 20),
          Text(
            receta.getTitulo(),
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20), // Espacio entre los textos
          Text(
            'Ingredientes:',
            style: Theme.of(context).textTheme.titleMedium,
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
          Text(
            'Instrucciones:',
            style: Theme.of(context).textTheme.titleMedium,
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


/*
class _CustomAppBar extends StatelessWidget {
  final Meal comida;

  const _CustomAppBar({required this.comida});
  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            comida.strMeal,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(comida.strMealThumb),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
*/
/*
class _FotoYNombre extends StatelessWidget {
  final MealReceta receta;

  const _FotoYNombre({Key? key, required this.receta}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(receta.getImage()),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                receta.getTitulo(),
                style: textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                receta.getTitulo(),
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
*/