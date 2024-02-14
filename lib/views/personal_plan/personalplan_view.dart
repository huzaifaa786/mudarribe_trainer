// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/planselectioncard.dart';
import 'package:mudarribe_trainer/components/priceinput.dart';
import 'package:mudarribe_trainer/components/search_dropdown.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/plans.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_controller.dart';

class PersonalPlanScreen extends StatefulWidget {
  const PersonalPlanScreen({super.key});

  @override
  State<PersonalPlanScreen> createState() => _PersonalPlanScreenState();
}

class _PersonalPlanScreenState extends State<PersonalPlanScreen> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalPlanController>(
      builder: (controller) => Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
                    automaticallyImplyLeading: false,
                    title: TitleTopBar(
                        name: 'Customizing Plan'.tr,
                        ontap: () {
                          Get.back();
                        }),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: box.read('locale') != 'ar'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      child: InputField(
                        controller: controller.plantitleController,
                        lable: 'Plan Title'.tr,
                      ),
                    ),
                    Directionality(
                      textDirection: box.read('locale') != 'ar'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      child: PriceInputField(
                        controller: controller.priceController,
                        lable: 'Price'.tr,
                      ),
                    ),
                    Directionality(
                      textDirection: box.read('locale') != 'ar'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      child: SearchDropdownField(
                        selectedvalue: controller.fromSelectedduration,
                        text: "Duration".tr,
                        items: PalnList(),
                        onChange: (value) {
                          setState(() {
                            controller.fromSelectedduration = value;
                            controller.checkFields();
                          });
                        },
                        searchController: controller.searchController,
                        searchInnerWidget: Container(
                          padding: const EdgeInsets.all(12),
                          child: TextFormField(
                            controller: controller.searchController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 14,
                              ),
                              hintText: 'Search items'.tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return (item.value
                              .toLowerCase()
                              .contains(searchValue.toLowerCase()));
                        },
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            controller.searchController.clear();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GradientText2(
                      text: 'Select plan category '.tr,
                      size: 18.0,
                    ),
                    Row(
                      children: [
                        GenderCard(
                          image: "assets/images/nutrition.svg",
                          selected:
                              controller.category == 'nutrition' ? true : false,
                          ontap: controller.onnutritiontap,
                          text: 'Nutrition Plan'.tr,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GenderCard(
                          image: "assets/images/excercise.svg",
                          ontap: controller.onexcercisetap,
                          selected:
                              controller.category == 'excercise' ? true : false,
                          text: 'Exercises Plan'.tr,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SelectPlanCard(
                      image: "assets/images/nutrition.svg",
                      image1: "assets/images/excercise.svg",
                      selected: controller.category == 'excercise&nutrition'
                          ? true
                          : false,
                      ontap: controller.onbothtap,
                      text: 'Exercises & Nutrition Plan'.tr,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GradientButton(
                      title: 'Submit'.tr,
                      onPressed: controller.areFieldsFilled.value
                          ? () {
                              controller.addplan().then((value) {
                                Get.back(result: controller.content);
                              });
                            }
                          : () {
                              UiUtilites.errorSnackbar('Fill out all fields'.tr,
                                  'Please fill all above fields'.tr);
                            },
                      selected: controller.areFieldsFilled.value,
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
