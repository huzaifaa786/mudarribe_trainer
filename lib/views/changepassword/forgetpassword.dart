// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/values/color.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, bottom: 110, right: 108, top: 30),
                  child: Text(
                    'Forget Password.',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: White),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(color: Color.fromARGB(255, 29, 28, 28)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Enter your Email please',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 195, 186, 186)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: InputField(
                      lable: 'Email',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GradientButton(title: 'Send Code', onPressed: () {})
          ],
        ),
      )),
    );
  }
}
