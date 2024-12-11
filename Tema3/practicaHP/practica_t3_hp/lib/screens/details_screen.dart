import 'package:flutter/material.dart';
import 'package:practica_t3_hp/models/meal.dart';
import 'package:practica_t3_hp/models/models.dart';
import 'package:practica_t3_hp/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    final Meal comidilla = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //_CustomAppBar(movie: comidilla),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(movie: comidilla),
                _Overview(
                  movie: comidilla,
                ),
                _Overview(movie: comidilla),
                //CastingCards(idMovie: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class _PosterAndTitile extends StatelessWidget {
  final Meal movie;

  const _PosterAndTitile({Key? key, required this.movie}) : super(key: key);
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
              image: NetworkImage(movie.idMeal),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                movie.idMeal,
                style: textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.idMeal,
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  ..._buildStarIcons(4),
                  const SizedBox(width: 5),
                  //Text('Nota: ${movie.voteAverage}', style: textTheme.bodyMedium),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildStarIcons(double rating) {
    return List.generate(10, (index) {
      if (rating >= index + 1) {
        return const Icon(Icons.star,
            size: 15, color: Colors.amber); // Estrella llena
      } else if (rating > index && rating < index + 1) {
        return const Icon(Icons.star_half,
            size: 15, color: Colors.amber); // Media estrella
      } else {
        return const Icon(Icons.star_border,
            size: 15, color: Colors.grey); // Estrella vacía
      }
    });
  }
}

class _Overview extends StatelessWidget {
  final Meal movie;

  const _Overview({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.idMeal,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
