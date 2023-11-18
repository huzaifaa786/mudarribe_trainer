// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GradientText2 extends StatelessWidget {
  const GradientText2({super.key, this.text, this.size});
  final text;
  final size;
  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.w500),
      colors: const [Color(0xff727dcd), Color(0xff58e1ff)],
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
