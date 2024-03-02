// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GradientText2 extends StatefulWidget {
  const GradientText2(
      {super.key, this.text, this.size = 12.0, this.weight = FontWeight.w500});
  final text;
  final size;
  final weight;

  @override
  State<GradientText2> createState() => _GradientText2State();
}

class _GradientText2State extends State<GradientText2> {
  @override
  Widget build(BuildContext context) {
    return GradientText(
      widget.text,
      style: TextStyle(fontSize: widget.size, fontWeight: FontWeight.w500),
      colors: const [Color.fromARGB(255, 78, 90, 181), Color.fromARGB(255, 54, 168, 193)],
    );

    // return Text(text,
    //     style: TextStyle(
    //         foreground: Paint()
    //           ..shader = LinearGradient(
    //                   begin: Alignment.topLeft,
    //                   end: Alignment.bottomLeft,
    //                   colors: [Color(4285693389), Color(4284015103)])
    //               .createShader(Rect.fromLTWH(0, 0, 200, 20))));
  }
}
