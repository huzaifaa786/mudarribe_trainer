// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/values/color.dart';

class MainUserCard extends StatelessWidget {
  const MainUserCard(
      {super.key, this.img, this.name, this.category, this.onUserImgTap});
  final img;
  final name;
  final category;
  final onUserImgTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
            // color:
            //     Get.isDarkMode ? bgContainer.withOpacity(0.6) : Color(4294375158),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(4292214271),
                  Color(4288538110),
                  Color(4289505535),
                  Color(4289494015),
                  Color(4289494015),
                  Color(4289491966),
                  Color(4289491966),
                  // Color(4289494015),
                ]),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              Get.isDarkMode
                  ? BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 8,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    )
                  : BoxShadow(
                      color: Colors.black.withOpacity(0.0),
                      spreadRadius: 8,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: onUserImgTap,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: GradientBoxBorder(
                          gradient: LinearGradient(colors: [
                            Color(4290773187),
                            Color(4290773187),
                            borderbottom,
                            borderbottom
                          ]),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          img,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  // Image.asset('assets/images/verifiedicon.png')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(category,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.7)
                            : Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
