import 'package:flutter/material.dart';

final List<Color> ColorP = [
  Colors.deepPurple.shade50,
  Colors.deepPurple.shade100,
  Colors.deepPurple,
  Color.fromRGBO(75, 80, 110, 1),
  Color.fromRGBO(48, 54, 79, 1.0)
];

AppBar appBar(String title) => AppBar(
      elevation: 10,
      backgroundColor: ColorP[4],
      title: Hero(
        tag: title,
        child: Text(
          title,
          style: TextStyle(
              color: ColorP[0],
              letterSpacing: 3,
              decoration: TextDecoration.none,
              fontSize: 30,
              shadows: [
                Shadow(color: ColorP[3], blurRadius: 2, offset: Offset(3, 2))
              ],
              fontWeight: FontWeight.bold),
        ),
      ),
      centerTitle: true,
    );
