// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key,
  this.text,
  
   }):super(key: key);
   final text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Container(
        padding: const EdgeInsets.all(9),
    
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  foreground: Paint()
                    ..shader = LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [Color(4285693389), Color(4284015103)])
                        .createShader(Rect.fromLTWH(0, 0, 200, 20))),
            ),
            SizedBox(height: 16,),
            IconButtons(title: 'Upload', onPressed: () {})
          ],
        ),
        decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 32, 32, 32),
              offset: const Offset(0.0, 0.0),
              blurRadius: 4.0,
              spreadRadius: 4.0,
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
