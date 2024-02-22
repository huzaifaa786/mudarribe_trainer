// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_translator/google_translator.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';

import 'package:mudarribe_trainer/values/color.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.onPressDelete,
    required this.onPressClose,
    this.isClose = false,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.todate,
    required this.price,
    required this.capacity,
    required this.attendees,
    required this.eventStatus,
  }) : super(key: key);
  final title;
  final imageUrl;
  final onPressDelete;
  final onPressClose;
  final isClose;
  final address;
  final startTime;
  final endTime;
  final date;
  final todate;
  final price;
  final capacity;
  final eventStatus;
  final attendees;

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return Container(
      
      decoration: BoxDecoration(
        color: Get.isDarkMode ? bgContainer : lightbgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Get.isDarkMode ? white : maincolor,
                  ),
                ),
                InkWell(
                  onTap: onPressDelete,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SvgPicture.asset(
                      'assets/images/delete.svg',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery.sizeOf(context).width,
            child: Image.network(imageUrl),
          ),
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/location.svg',
                    color: Get.isDarkMode ? white : maincolor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.74,
                          child: Text(
                            address,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Color.fromARGB(255, 197, 191, 191)
                                  : maincolor,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 4),
              Directionality(
                textDirection: box.read('locale') == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/timeline.svg',
                      color: Get.isDarkMode ? Colors.white : maincolor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Text(
                        'From'.tr + ' $startTime ' + 'to'.tr + ' $endTime',
                        style: TextStyle(
                          color: Get.isDarkMode
                              ? Color.fromARGB(255, 197, 191, 191)
                              : maincolor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/calender1.svg',
                    color: Get.isDarkMode
                        ? Color.fromARGB(255, 197, 191, 191)
                        : maincolor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'From'.tr + ' $date ' + 'to'.tr + ' $todate',
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? Color.fromARGB(255, 197, 191, 191)
                            : maincolor,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/peoplesharp.svg',
                    color: Get.isDarkMode
                        ? Color.fromARGB(255, 197, 191, 191)
                        : maincolor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'Total People amount:'.tr,
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? Color.fromARGB(255, 197, 191, 191)
                            : maincolor,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GradientText2(
                    text: '$attendees/$capacity',
                  )
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Price :'.tr,
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? Color.fromARGB(255, 197, 191, 191)
                          : maincolor,
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$price ' + ' AED'.tr,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : maincolor,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
          isClose == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onPressClose,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GradientText2(
                          text: 'Close event'.tr,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Closed'.tr,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
