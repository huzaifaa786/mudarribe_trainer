import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/components/plan_category_card.dart';
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
    var userId = Get.parameters['userId'] as String;
    var orderId = Get.parameters['orderId'] as String;
  
    return GetBuilder<SendPlanController>(
      initState: (state) async {
        Future.delayed(const Duration(milliseconds: 100), () {
          state.controller!.userId = userId;
          state.controller!.orderId = orderId;
        });
      },
      builder: (controller) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            title: TopBar(text: 'Send Plan'),
          ),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
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
                          selected:
                              controller.category == 'nutrition' ? true : false,
                          ontap: controller.onnutritiontap,
                          text: 'Nutrition Plan',
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        PlanCategoryCard(
                          image: "assets/images/excercise.svg",
                          ontap: controller.onexcercisetap,
                          selected:
                              controller.category == 'excercise' ? true : false,
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
                                Get.toNamed(AppRoutes.exercise, parameters: {
                                  "category": controller.category,
                                  "userId": controller.userId,
                                  "orderId": controller.orderId,
                                });
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
