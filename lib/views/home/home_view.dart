// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/main_card.dart';
import 'package:mudarribe_trainer/components/main_user_card.dart';
import 'package:mudarribe_trainer/models/trainer_story.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/chat/chat_list.dart';

import 'package:mudarribe_trainer/views/home/home_controller.dart';
import 'package:mudarribe_trainer/views/story/story_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeContoller>(
      builder: (controller) => controller.currentUser != null
          ? BusyIndicator(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  backgroundColor: Get.isDarkMode ? Colors.black: Colors.white,
                  body: SafeArea(
                    child: Column(
                      children: [
                        MainUserCard(
                          name: controller.currentUser!.name,
                          img: controller.currentUser!.profileImageUrl!,
                          categories: controller.currentUser!.categories,
                          onUserImgTap: () {
                                
                            Get.toNamed(AppRoutes.stories, parameters: {
                              "trainer_id": controller.currentUser!.id
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MainCard(
                                    name: "View Profile".tr,
                                    ontap: () {
                                      Get.toNamed(AppRoutes.profile);
                                    },
                                    image: 'assets/images/person.svg',
                                  ),
                                  MainCard(
                                    name: 'Chats'.tr,
                                    ontap: () {
                                      Get.to(() => ChatListScreen());
                                    },
                                    image: 'assets/images/chats.svg',
                                    dynamicColor: controller.chatLength > 0,
                                    bgColor: Get.isDarkMode ? lightbgColor : Colors.black 
                                  ),
                                  MainCard(
                                    name: 'Orders'.tr,
                                    ontap: () {
                                      Get.toNamed(AppRoutes.orders);
                                    },
                                    dynamicColor: controller.orderCount > 0,
                                    bgColor: Get.isDarkMode
                                        ? lightbgColor
                                        : Colors.black,
                                    image: 'assets/images/orders.svg',
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MainCard(
                                    name: 'Packages'.tr,
                                    ontap: () {
                                      Get.toNamed(AppRoutes.packagesScreen);
                                    },
                                    image: 'assets/images/packages.svg',
                                  ),
                                  MainCard(
                                    name: 'Edit Profile'.tr,
                                    ontap: () {
                                      Get.toNamed(AppRoutes.editprofile)!
                                          .then((value) => controller.getAppUser());
                                    },
                                    image: 'assets/images/person_setting.svg',
                                  ),
                                  MainCard(
                                    name: 'My Events'.tr,
                                    ontap: () {
                                      Get.toNamed(AppRoutes.myevent);
                                    },
                                    image: 'assets/images/events.svg',
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MainCard(
                                    name: 'My Sales'.tr,
                                    ontap: () {
                                      Get.toNamed(AppRoutes.sale);
                                    },
                                    image: 'assets/images/sales.svg',
                                  ),
                                   MainCard(
                                    name: "Report a problem".tr,
                                    ontap: () {
                                      Get.toNamed(AppRoutes.report);
                                    },
                                    image: 'assets/images/report.svg',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}
