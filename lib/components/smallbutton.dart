import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Smallbutton extends StatelessWidget {
  const Smallbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        border: GradientBoxBorder(
          // borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xff727dcd), Color(0xff00f8e9)]),
          width: 1,
        ),
      ),
    );
  }
}
