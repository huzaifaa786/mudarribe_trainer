// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/chatcard.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: TitleTopBar(
          name: 'Chats',
          ontap: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              ChatCard(name: 'Ali'),
              ChatCard(name: 'Ali'),
              ChatCard(name: 'Ali'),
              ChatCard(name: 'Ali'),
              ChatCard(name: 'Ali'),
              ChatCard(name: 'Ali'),
              ChatCard(name: 'Ali'),
              ChatCard(name: 'Ali'),
            ],
          ),
        ),
      )),
    );
  }
}
