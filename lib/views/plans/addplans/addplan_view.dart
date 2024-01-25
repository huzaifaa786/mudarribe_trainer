// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';

import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/plan_category_card.dart';
import 'package:mudarribe_trainer/components/planselectioncard.dart';
import 'package:mudarribe_trainer/components/priceinput.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/plans/addplans/addplan_controller.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({super.key});

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPlanController>(
      builder: (controller) => controller.currentUser != null
          ? BusyIndicator(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  appBar: AppBar(
                    forceMaterialTransparency: true,
                    automaticallyImplyLeading: false,
                    title: TitleTopBar(
                        name: 'New Package'.tr,
                        ontap: () {
                          Get.back();
                        }),
                  ),
                  body: Directionality(
                    textDirection:
                      box.read('locale') == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              InputField(
                                lable: 'Plan Title'.tr,
                                controller: controller.packagenameController,
                              ),
                              PriceInputField(
                                lable: 'Price'.tr,
                                controller: controller.priceController,
                              ),
                              InputField(
                                lable: 'Duration'.tr,
                                controller: controller.durationController,
                              ),
                              BioInputField(
                                lable: 'Description'.tr,
                                controller: controller.discriptionController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GradientText2(
                                text: 'Select plan category '.tr,
                                size: 18.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  PlanCategoryCard(
                                    image: "assets/images/excercise.svg",
                                    ontap: controller.onexcercisetap,
                                    selected: controller.category == 'excercise'
                                        ? true
                                        : false,
                                    text: 'Exercises'.tr,
                                  ),
                                  PlanCategoryCard(
                                    image: "assets/images/nutrition.svg",
                                    selected: controller.category == 'nutrition'
                                        ? true
                                        : false,
                                    ontap: controller.onnutritiontap,
                                    text: 'Nutrition'.tr,
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
                                    controller.category == 'excercise&nutrition'
                                        ? true
                                        : false,
                                ontap: controller.onbothtap,
                                text: ' Exercises & Nutrition'.tr,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                    child: GradientButton(
                      title: 'Submit'.tr,
                      onPressed: controller.areFieldsFilled.value
                          ? () {
                              controller.addpackage();
                            }
                          : () {
                              UiUtilites.errorSnackbar('Fill out all fields'.tr,
                                  'Please fill all above fields'.tr);
                            },
                      selected: controller.areFieldsFilled.value,
                    ),
                  ),
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}
