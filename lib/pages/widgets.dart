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
Widget circleWidget() {
  return Stack(
    children: [
      Align(
        alignment: const AlignmentDirectional(0, -3),
        child: Container(
          width: 400,
          height: 400,
          // color: Colors.blue,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(400),
            ),
            color: Color(0xff121526),
          ),
        ),
      ),
    ],
  );
}
