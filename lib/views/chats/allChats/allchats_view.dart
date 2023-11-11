// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mudarribe_trainer/components/chatcard.dart';

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
          child: SingleChildScrollView(
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
            ChatCard(name: 'Ali',),
              ChatCard(name: 'Ali',),
          ChatCard(name: 'Ali',),
             ChatCard(name: 'Ali',),
          ChatCard(name: 'Ali',),
          ChatCard(name: 'Ali',),
          ChatCard(name: 'Ali',),
          ChatCard(name: 'Ali',),
          ],
        ),
      )),
    );
  }
}
