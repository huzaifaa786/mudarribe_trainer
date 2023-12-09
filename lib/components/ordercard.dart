// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: bgContainer, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/person.png',
                        height: 35,
                        width: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Ahmed Yusif",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  Image.asset('assets/images/chat.png'),
                ],
              ),
              Row(
                children: [
                  GradientText(
                    'Package :',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    colors: [borderTop, borderbottom],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "1 month Lose Whight Plan",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  GradientText(
                    '      Price :',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    colors: [borderTop, borderbottom],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '250.44' + ' AED',
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ))
                ],
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.sendplanhome);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GradientText(
                    'Send Plan',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    colors: [borderTop, borderbottom],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 22,
          left: 11,
          child: Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [borderTop, borderbottom])),
            // color: borderbottom,
          ),
        ),
      ],
    );
  }
}
