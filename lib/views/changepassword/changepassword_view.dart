// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, duplicate_ignore, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_translator/google_translator.dart';
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
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangepasswordController>(
      builder: (controller) => BusyIndicator(
        child: Scaffold(
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Directionality(
                        textDirection: box.read('locale') == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   // ignore: prefer_const_literals_to_create_immutables
                            //   children: [
                            //     Icon(
                            //       Icons.arrow_back_ios_new,
                            //       color: Colors.white,
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, bottom: 50),
                                  child: Text(
                                    'Change Password'.tr,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                // height: 300,
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 40, bottom: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? Color.fromARGB(255, 15, 15, 15)
                                        : lightbgColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PasswordInputField(
                                        lable: 'Password'.tr,
                                        controller: controller.oldpassword,
                                        obscure:
                                            controller.obscureTextOldPassword,
                                        toggle: controller.toggle2,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      PasswordInputField(
                                        lable: 'New Password'.tr,
                                        controller: controller.newpassword,
                                        obscure: controller.obscureTextPassword,
                                        toggle: controller.toggle,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      PasswordInputField(
                                        controller: controller.confirmPassword,
                                        lable: 'Confirm New Password'.tr,
                                        obscure:
                                            controller.obscureTextCPassword,
                                        toggle: controller.toggle1,
                                      ),
                                    ])),
                            SizedBox(
                              height: 59,
                            ),
                            SizedBox(
                              height: 96,
                            ),
                            GradientButton(
                              title: 'Submit'.tr,
                              onPressed: controller.areFieldsFilled.value
                                  ? () {
                                      controller.changePassword();
                                    }
                                  : () {
                                      UiUtilites.errorSnackbar(
                                          'Fill out all fields'.tr,
                                          'Please fill all above fields'.tr);
                                    },
                              selected: controller.areFieldsFilled.value,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
