import 'package:flutter/material.dart';

//splash screen circle container design
Widget circleUI(double start, double y) {
  return Align(
    alignment: AlignmentDirectional(start, y),
    child: Container(
      height: 350,
      width: 350,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Color.fromARGB(255, 126, 77, 251)),
    ),
  );
}

//semi circle design under appbar
