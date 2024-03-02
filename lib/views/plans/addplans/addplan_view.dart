// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
import 'package:mudarribe_trainer/components/search_dropdown.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/values/plans.dart';
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
                    textDirection: box.read('locale') == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
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
                              SizedBox(height: 20),
                              // InputField(
                              //   lable: 'Duration'.tr,
                              //   controller: controller.durationController,
                              // ),
                              Directionality(
                                textDirection: box.read('locale') != 'ar'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: SearchDropdownField(
                                  selectedvalue:
                                      controller.fromSelectedduration,
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
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 14,
                                        ),
                                        hintText: 'Search items'.tr,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                lable: 'Description'.tr,
                                controller: controller.discriptionController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    GradientText2(
                                    text: 'Select plan images'.tr,
                                    size: 18.0,
                                  ),
                                
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.getImage(1);
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: controller.image1 != null
                                                ? Image.file(controller.image1!,
                                                    fit: BoxFit.cover)
                                                : Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          controller.getImage(2);
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: controller.image2 != null
                                                ? Image.file(controller.image2!,
                                                    fit: BoxFit.cover)
                                                : Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Gap(30),
                              GradientText2(
                                text: 'Select plan category '.tr,
                                size: 18.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
