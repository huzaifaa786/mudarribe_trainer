// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditPlans extends StatefulWidget {
  const EditPlans({super.key});

  @override
  State<EditPlans> createState() => _EditPlansState();
}

class _EditPlansState extends State<EditPlans> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 90,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 40),
                      child: SvgPicture.asset(
                        'assets/images/Vector 2.svg',
                      ),
                    ),
                    Text(
                      'Chats',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
