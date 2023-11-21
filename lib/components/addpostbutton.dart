// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
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

  final bool _isPressed = true;

  @override
  Widget build(BuildContext context) {
    Widget child = selected
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Text(
              'Click me',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        : Text('data');

    return child;
  }
}
