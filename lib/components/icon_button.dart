// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/values/color.dart';

class IconButtons extends StatelessWidget {
  const IconButtons({
    Key? key,
    @required this.title,
    @required this.onPressed,
    this.text,
    this.textcolor,
    this.icon,
    this.buttonWidth = 0.8,
    this.sreenRatio = 1,
    this.gradientColors = const [borderTop, borderbottom],
  }) : super(key: key);

  final title;
  final onPressed;
  final sreenRatio;
  final List<Color> gradientColors;
  final text;
  final textcolor;
  final icon;
  final buttonWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * sreenRatio,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/upload.png',
                  color: Colors.white,
                ),
                SizedBox(width: 10,),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
