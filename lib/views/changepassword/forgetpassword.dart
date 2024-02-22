// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/changepassword/forget_password_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordContoller>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: TopBar(
            text: "",
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 50, top: 40),
                    child: Text(
                      'Forget Password.'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode ? white : maincolor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? bgContainer : lightbgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Enter your Email please'.tr,
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? Color.fromARGB(255, 195, 186, 186)
                              : maincolor),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: InputField(
                        lable: 'Email'.tr,
                        controller: forgotPasswordContoller.emailController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              GradientButton(
                title: 'Send Code'.tr,
                onPressed: controller.areFieldsFilled.value
                    ? () {
                        controller.forgotPassword();
                      }
                    : () {
                        UiUtilites.errorSnackbar('Fill Email Field'.tr,
                            'Please fill above email field'.tr);
                      },
                selected: controller.areFieldsFilled.value,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
