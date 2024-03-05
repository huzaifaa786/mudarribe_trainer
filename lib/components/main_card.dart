// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';

class MainCard extends StatelessWidget {
  const MainCard(
      {super.key,
      this.name,
      this.ontap,
      this.image,
      this.dynamicColor = false,
      this.bgColor = white});
  final ontap;
  final name;
  final image;
  final dynamicColor;
  final bgColor;
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return Container(
      width: 100,
      child: GestureDetector(
        onTap: ontap,
        child: Column(
          children: [
            Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(4294375158),
                  boxShadow: [
                    Get.isDarkMode
                        ? BoxShadow(
                            color: borderTop.withOpacity(0.3),
                            offset: Offset(0.11, 0.1),
                            blurRadius: 8)
                        : BoxShadow(
                            color: lightbgColor,
                            offset: Offset(0.11, 0.1),
                            blurRadius: 8),
                    Get.isDarkMode
                        ? BoxShadow(
                            color: borderbottom.withOpacity(0.3),
                            offset: Offset(-0.1, -0.11),
                            blurRadius: 8,
                            spreadRadius: 1)
                        : BoxShadow(
                            color: lightbgColor,
                            offset: Offset(0.11, 0.1),
                            blurRadius: 8)
                  ],
                  borderRadius: BorderRadius.circular(45),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(colors: [
                      borderTop,
                      borderTop,
                      borderTop,
                      borderbottom
                    ]),
                    width: 1,
                  ),
                ),
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dynamicColor
                            ? bgColor
                            : Get.isDarkMode
                                ? Colors.black
                                : lightbgColor),
                    child: SvgPicture.asset(
                      image,
                      fit: BoxFit.scaleDown,
                    ))),
            Gap(9),
            Text(
              name,
              maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: box.read('Locale') == 'en' ? 14 : 10,
                fontWeight: FontWeight.w700,
                // height: 46 / 14,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(9),
          ],
        ),
      ),
    );
  }
}
