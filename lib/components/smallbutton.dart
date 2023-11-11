import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class smallbutton extends StatelessWidget {
  const smallbutton({super.key});

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
              colors: [Color(4285693389), Color(4278253801)]),
          width: 1,
        ),
      ),
    );
  }
}
