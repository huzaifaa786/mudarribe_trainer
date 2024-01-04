// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';

import 'package:mudarribe_trainer/values/color.dart';
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
  final price;
  final capacity;
  final eventStatus;
  final attendees;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgContainer,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(12),
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
                      color: Colors.white,
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
                    SvgPicture.asset('assets/images/location.svg'),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width*0.8,
                            child: Text(
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color.fromARGB(255, 197, 191, 191),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/timeline.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Text(
                        'from $startTime to $endTime',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 202, 200, 200),
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
                  children: [
                    SvgPicture.asset('assets/images/calender1.svg'),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        date,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 218, 216, 216),
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
                    SvgPicture.asset('assets/images/peoplesharp.svg'),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Total People amount:',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 217, 216, 216),
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
                      'Price:',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 196, 195, 195),
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '$price AED',
                      style: TextStyle(
                        color: Colors.white,
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
                            text: 'Close Event',
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
                        'Closed',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
