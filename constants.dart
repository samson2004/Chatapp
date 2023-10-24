import 'dart:ui';
import 'package:flutter/material.dart';

const Color bluecolor=Color(0XFF2D5296);//blue
const Color whitecolor=Color(0xFFF5F5F5);//white


class welcomepagebuttons extends StatelessWidget {
  welcomepagebuttons({ required this.textbutton});

  final String textbutton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
      padding: EdgeInsets.fromLTRB(0, 11, 0, 0),
      child: Text(textbutton,textAlign: TextAlign.center,style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600
      ),),
      decoration: BoxDecoration(
          color: Color(0XFF2D5296),
          borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}
