// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/values/color.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {super.key,
      this.userName,
      this.profileImage,
      this.onTapMessage,
      this.eventName,
      this.duration,
      this.price});

  final userName;
  final profileImage;
  final onTapMessage;
  final eventName;
  final price;
  final duration;

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
              color: Get.isDarkMode ? bgContainer : Color(4294375158),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.asset(
                          'assets/images/person.png',
                          height: 35,
                          width: 35,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          userName,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                      onTap: onTapMessage,
                      child: Image.asset(
                        'assets/images/chat.png',
                        color: Get.isDarkMode ? Colors.white : maincolor,
                      )),
                ],
              ),
              Row(
                children: [
                  GradientText2(
                    text: 'Event name'.tr + ':',
                    size: 12.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      eventName,
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
                  GradientText2(
                    text: 'Price'.tr + ':',
                  ),
                  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        price + ' AED'.tr,
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ))
                ],
              ),
              Row(
                children: [
                  GradientText2(
                    text: 'Date'.tr + ':',
                  ),
                  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        '$duration'.tr,
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ))
                ],
              ),
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