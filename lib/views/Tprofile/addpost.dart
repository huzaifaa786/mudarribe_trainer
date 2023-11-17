// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/button.dart';
import 'package:mudarribe_trainer/values/color.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
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
                  'New Post',
                  style: TextStyle(
                      color: White, fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 27,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 390,
              decoration: BoxDecoration(),
              child: Image.asset('assets/images/newpost.png'),
            ),
            BioInputField(
              lable: 'Write a caption',
            ),
            SizedBox(height: 20,),
            SimpleButton(title: 'post', onPressed: () {})
          ],
        ),
      )),
    );
  }
}
