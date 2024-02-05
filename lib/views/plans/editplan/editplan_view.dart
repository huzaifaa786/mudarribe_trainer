// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';

import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/plan_category_card.dart';
import 'package:mudarribe_trainer/components/planselectioncard.dart';
import 'package:mudarribe_trainer/components/priceinput.dart';
import 'package:mudarribe_trainer/components/search_dropdown.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/values/plans.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/plans/editplan/editplan_controller.dart';
import 'package:provider/provider.dart';

class EditPlanView extends StatefulWidget {
  const EditPlanView({super.key});

  @override
  State<EditPlanView> createState() => _EditPlanViewState();
}

class _EditPlanViewState extends State<EditPlanView> {
  @override
  Widget build(BuildContext context) {
    String id = Get.arguments;
    GetStorage box = GetStorage();
    return GetBuilder<EditPlanController>(
      initState: (state) async {
        Future.delayed(Duration(milliseconds: 100), () {
          state.controller!.getTrainerPackage(id);
        });
      },
      builder: (controller) => BusyIndicator(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              automaticallyImplyLeading: false,
              title: TitleTopBar(
                  name: 'Edit Package'.tr,
                  ontap: () {
                    Get.back();
                  }),
            ),
            body: SingleChildScrollView(
              child: Directionality(
                textDirection: box.read('locale') == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
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
                          controller: controller.priceController,
                          lable: 'Price'.tr,
                        ),
                        // InputField(
                        //   controller: controller.durationController,
                        //   lable: 'Duration'.tr,
                        // ),

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
                        BioInputField(
                          controller: controller.discriptionController,
                          lable: 'Description'.tr,
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
                          selected: controller.category == 'excercise&nutrition'
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
              padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
              child: GradientButton(
                title: 'Submit'.tr,
                onPressed: controller.areFieldsFilled.value
                    ? () {
                        controller.updatePackage();
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
      ),
    );
  }
}
