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
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_controller.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
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
                          backgroundImage: controller.profileImage != null
                              ? AssetImage(controller.profileImage!.path)
                              : AssetImage("assets/images/logo.png"),
                        ),
                        Positioned(
                            bottom: 23,
                            right: 17,
                            child: RawMaterialButton(
                              onPressed: () {
                                controller.selectProfileImage();
                              },
                              elevation: 2.0,
                              // fillColor: Color(0xFFF5F6F9),
                              // ignore: sort_child_properties_last
                              child: controller.profileImage != null
                                  ? Text('')
                                  : Icon(
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
                    child: GradientText2(
                      text: 'Choose photo',
                    ),
                  ),
                  InputField(
                    lable: 'Name',
                    controller: controller.nameController,
                  ),
                  InputField(
                    lable: 'Email',
                    controller: controller.emailController,
                  ),
                  PasswordInputField(
                    lable: 'Password',
                    obscure: controller.obscureTextPassword,
                    toggle: controller.togglePassword,
                    controller: controller.passwordController,
                  ),
                  PasswordInputField(
                    lable: 'Confirm Password',
                    obscure: controller.obscureTextCPassword,
                    toggle: controller.toggleCPassword,
                    controller: controller.confirmPasswordController,
                  ),
                  BioInputField(
                    lable: 'Bio',
                    controller: controller.bioController,
                  ),
                  Container(
                    child: DropInputField(
                      label: 'Category Of Train',
                      hint: 'Select Category',
                      value: controller.dropdownvalue,
                      onChanged: (String? newValue) {
                        setState(() {
                          controller.dropdownvalue = newValue!;
                        });
                      },
                      items: controller.items.map((String item) {
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
                    value: controller.dropdownvalue,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.dropdownvalue = newValue!;
                      });
                    },
                    items: controller.items.map((String item) {
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
                      children: [
                        GradientText2(
                          text: 'Gender ?',
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GenderCard(
                        text: 'Male',
                        image: "assets/images/male.svg",
                        selected:
                            signupController.selected == 'male' ? true : false,
                        ontap: signupController.onmaletap,
                      ),
                      GenderCard(
                        text: 'Female',
                        image: "assets/images/female.svg",
                        ontap: signupController.onfemaletap,
                        selected: signupController.selected == 'female'
                            ? true
                            : false,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                    title: 'Submit',
                    onPressed: controller.areFieldsFilled.value
                        ? () {
                            controller.selectedCategories;
                          }
                        : () {
                            UiUtilites.errorSnackbar('Fill out all fields',
                                'Please fill all above fields');
                          },
                    selected: controller.areFieldsFilled.value,
                  )
                ])),
          ),
        ),
      ),
    );
  }
}
