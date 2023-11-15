// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';

import 'package:mudarribe_trainer/values/color.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgContainer,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.86,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fitness ClubEvent!',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/delete.svg',
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              child: Image.asset(
                'assets/images/cardImage.png',
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/location.svg'),
                    Text(
                        ' Dubai',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '   Street 2367, Zaied Hotiel',
                      style: TextStyle(
                        color: Color.fromARGB(255, 197, 191, 191),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/timeline.svg'),
                    Text(
                      '  from 3 : 00 to 05 : 00 pm',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 202, 200, 200),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/calender1.svg'),
                    Text(
                      '    23/11/2023',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 218, 216, 216),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/peoplesharp.svg'),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 4),
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
                    GradientText2(text: ' 3/34',)
                  ],
                ),
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
                      ' 150.00 AED',
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
             Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GradientText2(
                        text: 'Join Event',
                        size: 12.0,
                      ),
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}
