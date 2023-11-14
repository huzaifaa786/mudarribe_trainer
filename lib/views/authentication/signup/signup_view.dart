// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/card.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/dropdown_input.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/password_inputField.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_controller.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    print(signinController.selected);
    return GetBuilder<SigninController>(
      builder: (controller) => Scaffold(
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
                              onPressed: () {signinController.selectProfileImage();},
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

                   padding: const EdgeInsets.only(top: 12),
                   child: GradientText2(text: 'Choose photo',),
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
                  Container(
                    
                    child: DropInputField(
                      label: 'Category Of Train',
                      hint: 'Select Category',
                      value: dropdownvalue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            selectionColor: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  DropInputField(
                    label: 'spoken languages',
                    hint: 'Select Category',
                    value: dropdownvalue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      );
                    }).toList(),
                
                  ),
                  Card1(
                    text: 'Upload Your Certificate',
                  ),
                  Card1(
                    text: 'Upload Your ID or Passport',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [GradientText2(text: 'Gender ?',)],),
                  ),
                  Row(
                    children: [
                      GenderCard(
                        text: 'male',
                        image: "assets/images/male.svg",
                        selected:
                            signinController.selected == 'male' ? true : false,
                        ontap: signinController.onmaletap,
                      
                      ),
                      GenderCard(
                           text: 'female',
                        image: "assets/images/female.svg",
                        ontap: signinController.onfemaletap,
                         selected:
                            signinController.selected == 'female' ? true : false,
                            
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GradientButton(title: 'Submit', onPressed: () {})
                ])),
          ),
        ),
      ),
    );
  }
}