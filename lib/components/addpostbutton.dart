// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/values/color.dart';

class AddPostbutton extends StatelessWidget {
  const AddPostbutton({
    Key? key,
    @required this.title,
    @required this.onPressed,
    this.text,
    this.textcolor,
    this.icon,
    this.isValid = false,
    this.selected = false,
    this.buttonWidth = 0.8,
    this.sreenRatio = 1,
    this.type = 'post',
    this.color = maincolor,
  }) : super(key: key);
  final bool selected;
  final bool isValid;
  final title;
  final onPressed;
  final sreenRatio;
  final color;
  final text;
  final textcolor;
  final icon;
  final buttonWidth;
  final type;

  final bool _isPressed = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * buttonWidth,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            border: GradientBoxBorder(gradient: LinearGradient(
              colors: 
                   const [borderTop, borderbottom]
                  ,
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),width: 1.2),
            gradient: LinearGradient(
              colors: selected
                  ? [borderTop, borderbottom]
                  : [
                      const Color.fromARGB(255, 26, 25, 25),
                      const Color.fromARGB(255, 26, 25, 25)
                    ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            borderRadius: type == 'post' ? const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ).translate(),
          ),
        ),
      ),
    );
  }
}
