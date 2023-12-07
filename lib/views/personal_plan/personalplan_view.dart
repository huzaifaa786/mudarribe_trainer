// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/planselectioncard.dart';
import 'package:mudarribe_trainer/components/priceinput.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_controller.dart';

class PersonalPlanScreen extends StatefulWidget {
  const PersonalPlanScreen({super.key});

  @override
  State<PersonalPlanScreen> createState() => _PersonalPlanScreenState();
}

class _PersonalPlanScreenState extends State<PersonalPlanScreen>
    with TickerProviderStateMixin {
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
                     controller: controller.plantitleController,
                    lable: 'Plan Title',
                  ),
                  PriceInputField(
                     controller: controller.priceController,
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
                        selected: personalPlanController.category == 'nutrition'
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
                        selected: personalPlanController.category == 'excercise'
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
                    selected:
                        personalPlanController.category == 'excercise&nutrition' ? true : false,
                    ontap: personalPlanController.onbothtap,
                    text: ' Exercises & Nutrition \n Plan',
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GradientButton(
                    title: 'Submit ',
                    onPressed: controller.areFieldsFilled.value
                        ? () {
                            controller.addplan();
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
    );
  }
}
