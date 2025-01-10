import 'package:flutter/material.dart';

class NewsSlider extends StatelessWidget {
  final List<String> news;
  const NewsSlider({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (news.isEmpty) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 280,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Random Meals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: news.length,
                itemBuilder: (_, int index) => _MealPoster(
                      //meal: mealsAlAzar[index],
                    )),
          )
        ],
      ),
    );
  }
}

class _MealPoster extends StatelessWidget {
  //final MealReceta meal;
  //const _MealPoster({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            //onTap: () => Navigator.pushNamed(context, 'details',
            //    arguments: meal.getIdMeal()),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage('assets/no-image.jpg'),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text(
              "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
