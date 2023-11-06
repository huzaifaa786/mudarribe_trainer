// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/card.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/dropdown_input.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/large_button.dart';
import 'package:mudarribe_trainer/components/password_inputField.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/signin.dart/signin_controller.dart';

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
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Fill Your Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 19,
                ),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      ),
                      Positioned(
                          bottom: 23,
                          right: 17,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            // fillColor: Color(0xFFF5F6F9),
                            // ignore: sort_child_properties_last
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                              size: 39,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Choose photo',
                    style: TextStyle(color: White),
                  ),
                ),
                InputField(
                  lable: 'Name',
                ),
                InputField(
                  lable: 'Email',
                ),
                PasswordInputField(
                  lable: 'password',
                  obscure: signinController.obscureTextPassword,
                  toggle: signinController.toggle,
                ),
                PasswordInputField(
                  lable: 'Confirm Password',
                  obscure: signinController.obscureTextCPassword,
                  toggle: signinController.toggle1,
                ),
                BioInputField(
                  lable: 'Bio',
                ),
                dropInputField(
                  lable: 'Category Of Train',
                ),
                dropInputField(
                  lable: 'spoken languages',
                ),
                Card1(
                  text: 'Upload Your Certificate',
                ),
                Card1(
                  text: 'Upload Your ID or Passport',
                ),
                Row(
                  children: [
                    GenderCard(
                      image: "assets/images/male.png",
                      selected:
                          signinController.selected == 'male' ? true : false,
                      ontap: signinController.onmaletap,
                    ),
                    GenderCard(
                      image: "assets/images/female.png",
                      selected:
                          signinController.selected == 'female' ? true : false,
                      ontap: signinController.onfemaletap,
                    ),
                  ],
                )
              ])),
        ),
      ),
    );
  }
}
