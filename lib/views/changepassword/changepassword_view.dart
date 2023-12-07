// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, duplicate_ignore, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/large_button.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/password_inputField.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/changepassword/changePassword_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangepasswordController>(
      builder: (controller) => BusyIndicator(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 50),
                          child: Text(
                            'Change Password.',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: white),
                          ),
                        ),
                      ],
                    ),
                     Container(
                      // height: 300,
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top:40, bottom: 25),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 21, 21, 21),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    PasswordInputField(
                      lable: 'Password',
                      controller: controller.oldpassword,
                      obscure: controller.obscureTextOldPassword,
                      toggle: controller.toggle2,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    PasswordInputField(
                      lable: 'New Password',
                      controller: controller.newpassword,
                      obscure: controller.obscureTextPassword,
                      toggle: controller.toggle,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    PasswordInputField(
                      controller: controller.confirmPassword,
                      lable: 'Confirm New Password',
                      obscure: controller.obscureTextCPassword,
                      toggle: controller.toggle1,
                    ),])),
                    SizedBox(
                      height: 59,
                    ),
                    SizedBox(
                      height: 96,
                    ),
                    GradientButton(
                      title: 'Submit',
                      onPressed: controller.areFieldsFilled.value
                          ? () {
                              controller.changePassword();
                            }
                          : () {
                              UiUtilites.errorSnackbar('Fill out all fields',
                                  'Please fill all above fields');
                            },
                      selected: controller.areFieldsFilled.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
