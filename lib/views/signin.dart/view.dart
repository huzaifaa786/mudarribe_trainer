import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/components/large_button.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            Text('Fill Your Information')
          ],
        ),
      )),
    );
  }
}
