// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/values/color.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key,
  this.text,
  this.ontap
   }):super(key: key);
   final text;
   final ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Container(
        padding: const EdgeInsets.all(12),
    
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
            IconButtons(title: 'Upload', onPressed: ontap)
          ],
        ),
        decoration: BoxDecoration(
          color: bgContainer,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
