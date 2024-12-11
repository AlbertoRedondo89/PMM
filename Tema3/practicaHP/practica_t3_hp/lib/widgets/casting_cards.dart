/*import 'package:flutter/material.dart';
import 'package:practica_t3_hp/models/models.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:practica_t3_hp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int idMovie;

  const CastingCards({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealsProvider>(context, listen: false);

    return FutureBuilder(
      future: mealsProvider.getMovieCast(idMovie),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final casting = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: casting.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) =>
                _CastCard(casting[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;
  const _CastCard(this.cast);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
*/