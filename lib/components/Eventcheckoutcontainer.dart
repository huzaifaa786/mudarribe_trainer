// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'package:mudarribe_trainer/values/color.dart';

class EventcheckoutContainer extends StatelessWidget {
  const EventcheckoutContainer({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.userBio,
    required this.eventDate,
    required this.bannerPrice,
  });
  final userName;
  final userImage;
  final userBio;
  final eventDate;
  final bannerPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 130,
      padding: EdgeInsets.only(bottom: 12),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color:  Get.isDarkMode? bgContainer: Colors.grey.withOpacity(0.2) ,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19, top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 184, 66, 186),
                            Color.fromARGB(255, 111, 127, 247),
                          ],
                        ),
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(userImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 10.4),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color:  Get.isDarkMode? white: maincolor ,
                            ),
                          ),
                          Container(
                            width: Get.width * 0.68,
                            child: Text(
                              userBio,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                color:  Get.isDarkMode? white.withOpacity(0.6000000238418579): maincolor ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/calender1.svg', color:  Get.isDarkMode? white: maincolor ,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 0),
                                  child: Text(
                                    eventDate,
                                    style: TextStyle(
                                       color:  Get.isDarkMode? white: maincolor ,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    right: 14,
                  ),
                  child: Text(
                    '$bannerPrice AED',
                    style: TextStyle(
                       color:  Get.isDarkMode? white: maincolor ,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ) ),
            ],
          )
        ],
      ),
    );
  }
}
