import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  final double initialRating;
  final ValueChanged<double> onRatingUpdate;

  // Constructor que acepta los parámetros iniciales
  const CustomRatingBar({super.key, 
    required this.initialRating,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      itemCount: 10,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
          case 1:
            return const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 2:
          case 3:
            return const Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 4:
          case 5:
            return const Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 6:
          case 7:
            return const Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 8:
          case 9:
            return const Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return const Icon(
              Icons.error,
              color: Colors.grey,
            );
        }
      },
      onRatingUpdate: onRatingUpdate,  // Actualiza la calificación
    );
  }
}