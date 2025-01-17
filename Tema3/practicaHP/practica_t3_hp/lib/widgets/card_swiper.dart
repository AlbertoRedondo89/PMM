import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:practica_t3_hp/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Meal> meals;
  const CardSwiper({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (meals.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
          itemCount: meals.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final meal = meals[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: meal.idMeal),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 8,
                          offset: const Offset(0, 4), // Desplazamiento de la sombra
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                          10), // Opcional: bordes redondeados
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10), // Bordes redondeados para la imagen
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(meal.strMealThumb),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        width: size.width * .6,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                        child: Text(
                          meal.strMeal,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )),
                  )
                ],
              ),
            );
          },
        ));
  }
}
