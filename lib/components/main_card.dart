// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key, this.name, this.ontap, this.image});
  final ontap;
  final name;
  final image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: borderTop.withOpacity(0.3),
                      offset: Offset(0.11, 0.1),
                      blurRadius: 8),
                  BoxShadow(
                      color: borderbottom.withOpacity(0.3),
                      offset: Offset(-0.1, -0.11),
                      blurRadius: 8,
                      spreadRadius: 1)
                ],
                borderRadius: BorderRadius.circular(45),
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                      colors: [borderTop, borderTop, borderTop, borderbottom]),
                  width: 1,
                ),
              ),
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: SvgPicture.asset(
                    image,
                    fit: BoxFit.scaleDown,
                  ))),
          Text(
            name,
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 46 / 14,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
