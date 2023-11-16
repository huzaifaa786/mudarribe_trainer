import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/plans/sendplan/sendplan_controller.dart';

class HomePlan extends StatefulWidget {
  const HomePlan({super.key});

  @override
  State<HomePlan> createState() => _HomePlanState();
}

class _HomePlanState extends State<HomePlan> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return GetBuilder<SendPlanController>(
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
                      'SendPlan',
                      style: TextStyle(
                          color: White,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 29,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70,
                  child: Align(
                      alignment: Alignment.center,
                      child: GradientText2(
                        text: 'Choose Plan ',
                        size: 20.0,
                      )),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 37, 37, 37),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    GenderCard(
                      image: "assets/images/nutrition.svg",
                      selected: sendPlanController.selected == 'nutrition'
                          ? true
                          : false,
                      ontap: sendPlanController.onnutritiontap,
                      text: 'Nutrition Plan',
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GenderCard(
                      image: "assets/images/excercise.svg",
                      ontap: sendPlanController.onexcercisetap,
                      selected: sendPlanController.selected == 'excercise'
                          ? true
                          : false,
                      text: 'Exercises Plan',
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                GradientButton(
                  title: 'next',
                  onPressed: () {},
                  selected: sendPlanController.selected == '' ? false : true,
                )
              ],
            )),
      )),
    );
  }
}
