import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    this.text,
  });
  final text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            foreground: Paint()
              ..shader = LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Color(4285693389), Color(4284015103)])
                  .createShader(Rect.fromLTWH(0, 0, 200, 20))));
  }
}
