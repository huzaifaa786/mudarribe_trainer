// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/main_card.dart';
import 'package:mudarribe_trainer/components/main_user_card.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/views/chat/chat_list.dart';

import 'package:mudarribe_trainer/views/home/home_controller.dart';

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
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Column(
                  children: [
                    MainUserCard(
                      name: controller.currentUser!.name,
                      img: controller.currentUser!.profileImageUrl!,
                      category: controller.currentUser!.categories!.join('& '),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              MainCard(
                                name: "View Profile",
                                ontap: () {
                                  Get.toNamed(AppRoutes.profile);
                                },
                                image: 'assets/images/person.svg',
                              ),
                              MainCard(
                                name: 'Chats',
                                ontap: () {
                                  Get.to(() => ChatListScreen());
                                },
                                image: 'assets/images/chats.svg',
                              ),
                              MainCard(
                                name: 'Orders',
                                ontap: () {
                                  Get.toNamed(AppRoutes.orders);
                                },
                                image: 'assets/images/orders.svg',
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MainCard(
                                name: 'Packages',
                                ontap: () {
                                  Get.toNamed(AppRoutes.packagesScreen);
                                },
                                image: 'assets/images/packages.svg',
                              ),
                              MainCard(
                                name: 'Edit Profile',
                                ontap: () {
                                  Get.toNamed(AppRoutes.editprofile)!
                                      .then((value) => controller.getAppUser());
                                },
                                image: 'assets/images/person_setting.svg',
                              ),
                              MainCard(
                                name: 'My Events',
                                ontap: () {
                                  Get.toNamed(AppRoutes.myevent);
                                },
                                image: 'assets/images/events.svg',
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainCard(
                                name: 'My Sales',
                                ontap: () {
                                  Get.toNamed(AppRoutes.sale);
                                },
                                image: 'assets/images/sales.svg',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}
