import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Calcbutton extends StatelessWidget {
  final String text;
  final Function callBack;
  final double textSize;
  final int bgColor;
  const Calcbutton({super.key, required this.callBack, required this.text,  this.textSize = 20, this.bgColor = 0xFF21252B});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        width: 65,
        height: 65,
        child: TextButton(
          onPressed: ()=>{callBack(text)},
          style: TextButton.styleFrom(
            backgroundColor: Color(bgColor),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            textStyle: const TextStyle(fontSize: 20)
          ),
          child: Text(
            text,style: GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: textSize
              )
            ),
          )
        ),
      ),
    );
  }
}