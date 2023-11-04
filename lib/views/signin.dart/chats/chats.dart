// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 154,
            color: Colors.black,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/Vector 2.svg',
                  // Replace with the path to your SVG file
                  // Set the height as per your preference
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
