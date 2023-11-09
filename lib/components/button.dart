import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/values/color.dart';

class SimpleButton extends StatefulWidget {
  const SimpleButton({
    Key? key,
    @required this.title,
    @required this.onPressed,
    this.text,
    this.textcolor,
    this.icon,
    this.buttonWidth = 0.8,
    this.sreenRatio = 1,
    this.color = maincolor,
  }) : super(key: key);

  final title;
  final onPressed;
  final sreenRatio;
  final color;
  final text;
  final textcolor;
  final icon;
  final buttonWidth;

  @override
  _SimpleButtonState createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  bool _isPressed = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
       
        child: SizedBox(
          width: MediaQuery.of(context).size.width * widget.sreenRatio,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
              border:GradientBoxBorder(
                      gradient: LinearGradient(
                          colors: [borderTop, borderbottom],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft),
                      width: 4,
                    )
                  
            ),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
