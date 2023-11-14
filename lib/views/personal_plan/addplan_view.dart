// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/planselectioncard.dart';
import 'package:mudarribe_trainer/components/priceinput.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_controller.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({Key? key});

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalPlanController>(
      builder: (controller) => Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
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
                        'New Package',
                        style: TextStyle(
                            color: White,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                    lable: 'Plan Title',
                  ),
                  PriceInputField(
                    lable: 'Price',
                  ),
                  InputField(
                    lable: 'Duration',
                  ),
                  BioInputField(
                    lable: 'discription',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GradientText2(
                    text: 'Select plan catigory ',
                    size: 18.0,
                  ),
                  Row(
                    children: [
                      GenderCard(
                        image: "assets/images/nutrition.svg",
                        selected: personalPlanController.selected == 'nutrition'
                            ? true
                            : false,
                        ontap: personalPlanController.onnutritiontap,
                        text: 'Nutrition Plan',
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GenderCard(
                        image: "assets/images/excercise.svg",
                        ontap: personalPlanController.onexcercisetap,
                        selected: personalPlanController.selected == 'excercise'
                            ? true
                            : false,
                        text: 'Exercises Plan',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SelectPlanCard(
                    image: "assets/images/nutrition.svg",
                    image1: "assets/images/excercise.svg",
                    selected: personalPlanController.selected == 'both'
                        ? true
                        : false,
                    ontap: personalPlanController.onbothtap,
                    text: ' Exercises & Nutrition \n Plan',
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 30,left: 20,right: 20),
          child: GradientButton(
            title: 'next',
            onPressed: () {},
            selected: personalPlanController.selected == '' ? false : true,
          ),
        ),
      ),
    );
  }
}
