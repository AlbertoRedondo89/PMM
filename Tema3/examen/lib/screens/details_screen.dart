import 'package:flutter/material.dart';
import 'package:examen/models/models.dart';
import 'package:examen/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    final Movie peli = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: peli),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(movie: peli),
                _Overview(movie: peli,),
                _Overview(movie: peli),
                CastingCards(idMovie: peli.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});
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
            movie.title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullPosterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({Key? key, required this.movie}) : super(key : key);
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
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                movie.title,
                style: textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle,
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  ..._buildStarIcons(movie.voteAverage),
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
        return const Icon(Icons.star, size: 15, color: Colors.amber); // Estrella llena
      } else if (rating > index && rating < index + 1) {
        return const Icon(Icons.star_half, size: 15, color: Colors.amber); // Media estrella
      } else {
        return const Icon(Icons.star_border, size: 15, color: Colors.grey); // Estrella vacía
      }
    });
  }

}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({Key? key, required this.movie}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
