// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/eventdetailcard.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({super.key});

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              SizedBox(
                width: 23,
              ),
              Text(
                'My Events',
                style: TextStyle(
                    color: White, fontSize: 25, fontWeight: FontWeight.w500),
              )
            ],
          ),

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
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.contain,
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
                      'Salim Ahmed',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Body Building& lifting trainer',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.6000000238418579),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          EventDetailsCard()
        ],
      )),
    );
  }
}
