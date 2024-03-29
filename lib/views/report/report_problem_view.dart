// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, duplicate_ignore, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/password_inputField.dart';
import 'package:mudarribe_trainer/components/textgradient.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/report/report_problem_contoller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ReportProblemView extends StatefulWidget {
  const ReportProblemView({super.key});

  @override
  State<ReportProblemView> createState() => _ReportProblemViewState();
}

class _ReportProblemViewState extends State<ReportProblemView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportProblemController>(
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
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              controller.i = 0;
                            });
                          },
                          child: Container(
                              height: 40,
                              width: Get.width * 0.35,
                              decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? controller.i == 0 ? lightbgColor: bgContainer 
                                      : controller.i == 0 ? bgContainer: lightbgColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: GradientText1(
                                  size: 16.0,
                                  text: 'Report'.tr,
                                ),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              controller.i = 1;
                            });
                          },
                          child: Container(
                              height: 40,
                              width: Get.width * 0.35,
                              decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? controller.i == 1 ? lightbgColor: bgContainer 
                                      : controller.i == 1 ? bgContainer: lightbgColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: GradientText1(
                                  size: 16.0,
                                  text: 'Suggestion'.tr,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: Text(
                            controller.i == 0
                                ? 'What’s the problem?'.tr
                                : 'What’s the suggestion?'.tr,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 40, bottom: 40),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Get.isDarkMode ? bgContainer : lightbgColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: controller.formKey,
                              child: InputField(
                                lable: controller.i == 0
                                    ? 'Text'.tr
                                    : 'Suggestion Text'.tr,
                                maxlines: 5,
                                controller: controller.report,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 43),
                              child: GestureDetector(
                                child: Container(
                                  height: 52,
                                  width: 215,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: borderbottom),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        controller.reportImage == null
                                            ? Image.asset(
                                                'assets/images/image.png',
                                                height: 15,
                                                width: 20,
                                              )
                                            : Container(
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
                                              ),
                                        controller.reportImage != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                ),
                                                child: GradientText1(
                                                  text: 'Uploaded'.tr,
                                                ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                ),
                                                child: GradientText1(
                                                  text: 'Upload Photo'.tr,
                                                ),
                                              )
                                      ]),
                                ),
                                onTap: () {
                                  controller.reportuploadimage();
                                },
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GradientButton(
                      title: 'Submit'.tr,
                      selected: controller.areFieldsFilled.value,
                      onPressed: controller.areFieldsFilled.value
                          ? () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.reportfun();
                              }
                            }
                          : () {
                              if (controller.formKey.currentState!
                                  .validate()) {}
                            },
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
