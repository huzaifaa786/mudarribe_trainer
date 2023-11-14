// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/eventdetailcard.dart';
import 'package:mudarribe_trainer/values/color.dart';

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
          EventDetailsCard()
        ],
      )),
    );
  }
}
