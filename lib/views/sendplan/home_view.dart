import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/sendplan/sendplan_controller.dart';

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
                const Row(
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
                const SizedBox(
                  height: 29,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 37, 37, 37),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: GradientText2(
                        text: 'Choose Plan ',
                        size: 20.0,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    GenderCard(
                      image: "assets/images/nutrition.svg",
                      selected: sendPlanController.category == 'nutrition'
                          ? true
                          : false,
                      ontap: sendPlanController.onnutritiontap,
                      text: 'Nutrition Plan',
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GenderCard(
                      image: "assets/images/excercise.svg",
                      ontap: sendPlanController.onexcercisetap,
                      selected: sendPlanController.category == 'excercise'
                          ? true
                          : false,
                      text: 'Exercises Plan',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                GradientButton(
                  title: 'Save Changes',
                  onPressed: controller.areFieldsFilled.value
                      ? () {
                          if (controller.category == 'nutrition' ||
                              controller.category == 'excercise') {
                            Get.toNamed(AppRoutes.exercise,
                                arguments: controller.category);
                          }
                        }
                      : () {
                          UiUtilites.errorSnackbar('Fill out all fields',
                              'Please fill all above fields');
                        },
                  selected: controller.areFieldsFilled.value,
                )
              ],
            )),
      )),
    );
  }
}
