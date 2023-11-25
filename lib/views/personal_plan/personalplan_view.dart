// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/planselectioncard.dart';
import 'package:mudarribe_trainer/components/priceinput.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_controller.dart';

class PersonalPlan extends StatefulWidget {
  const PersonalPlan({super.key});

  @override
  State<PersonalPlan> createState() => _PersonalPlanState();
}

class _PersonalPlanState extends State<PersonalPlan>
    with TickerProviderStateMixin {

  Widget build(BuildContext context) {
    return GetBuilder<PersonalPlanController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
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
                      'Customizing  Plan',
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
                SizedBox(height: 16,),
                SelectPlanCard(
                  image: "assets/images/nutrition.svg",
                  image1: "assets/images/excercise.svg",
                  selected:
                      personalPlanController.selected == 'both' ? true : false,
                  ontap: personalPlanController.onbothtap,
                  text: ' Exercises & Nutrition \n Plan',
                ),
                SizedBox(height: 25,),
                   GradientButton(
                  title: 'next',
                  onPressed: () {},
                  selected: personalPlanController.selected == '' ? false : true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
