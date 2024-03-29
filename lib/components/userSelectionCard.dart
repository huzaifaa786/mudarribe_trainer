// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/values/color.dart';

class SelectUserCard extends StatelessWidget {
  const SelectUserCard({super.key, this.text, this.ontap, this.selected});
  final ontap;
  final text;
  final selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            border: selected == true
                ? GradientBoxBorder(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [borderTop, borderbottom]),
                    width: 3,
                  )
                : Border.all(),
             color:  Get.isDarkMode? bgContainer: white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Color.fromARGB(255, 44, 42, 42),
            //     offset: const Offset(0.0, 0.0),
            //     blurRadius: 4.0,
            //     spreadRadius: 4.0,
            //   ), //BoxShadow
            // ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                 color:  Get.isDarkMode? white: maincolor ,
                height: 52 / 20,
              ),
            ) ,
          ),
        ),
      ),
      // selected == true
      //     ? Positioned(
      //       right: 12,
      //       top: 8,
      //         child: Icon(
      //         Icons.check_circle,
      //         color: mainColor,
      //       ))
      //     : Positioned(child: Text(''))
      //   ],
      // ),
    );
  }
}
