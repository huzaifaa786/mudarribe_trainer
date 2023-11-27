// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/planselectioncard.dart';
import 'package:mudarribe_trainer/components/priceinput.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/plans/addplans/addplan_controller.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({super.key});

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          title: TitleTopBar(name: 'New Package', ontap: () {}),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
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
                    lable: 'Discription',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GradientText2(
                    text: 'Select plan category ',
                    size: 18.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GenderCard(
                        image: "assets/images/excercise.svg",
                        ontap: controller.onexcercisetap,
                        selected:
                            controller.selected == 'excercise' ? true : false,
                        text: 'Exercises',
                      ),
                      GenderCard(
                        image: "assets/images/nutrition.svg",
                        selected:
                            controller.selected == 'nutrition' ? true : false,
                        ontap: controller.onnutritiontap,
                        text: 'Nutrition',
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
                    text: ' Exercises & Nutrition',
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
          padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          child: GradientButton(
            title: 'Submit ',
            onPressed: () {
              UiUtilites.successAlert(context, 'Package Added\nSuccessfully !');
            },
            selected: personalPlanController.selected == '' ? false : true,
          ),
        ),
      ),
    );
  }
}
