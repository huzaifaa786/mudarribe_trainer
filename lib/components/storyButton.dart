// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/values/color.dart';

class StoryButton extends StatelessWidget {
  const StoryButton({
    Key? key,
   
    @required this.title,

     this.isValid = false,
    this.selected = false, // Default value is false
  }) : super(key: key);

  final title;

  final bool selected;
 final bool isValid;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: selected
                ? [borderTop, borderbottom]
                : [const Color.fromARGB(255, 26, 25, 25), const Color.fromARGB(255, 26, 25, 25)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
         
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ).translate(),
        ),
      ),
    );
  }
}
