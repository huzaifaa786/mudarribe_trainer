// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/addpostbutton.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/main_card.dart';
import 'package:mudarribe_trainer/components/main_user_card.dart';
import 'package:mudarribe_trainer/components/storyButton.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/permissions.dart';
import 'package:mudarribe_trainer/views/chat/chat_list.dart';
import 'package:mudarribe_trainer/views/home/home_controller.dart';
import 'package:stories_editor/stories_editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _smallButtonsVisible = false;

  void toggleSmallButtonsVisibility() {
    setState(() {
      _smallButtonsVisible = !_smallButtonsVisible;
    });
  }

  @override
  void initState() {
    getpermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeContoller>(
      builder: (controller) => controller.currentUser != null
          ? BusyIndicator(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
                  bottomNavigationBar: Container(
                    height: 50,
                    color: Get.isDarkMode ? bgContainer : lightbgColor,
                  ),
                  floatingActionButton: GestureDetector(
                    onTap: () {
                      toggleSmallButtonsVisibility();
                      // AddPostbutton(
                      //   title: 'add post',
                      //   onPressed: () {},
                      //   selected: profileController.selected == '' ? false : true,
                      // );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.96, 0.29),
                          end: Alignment(0.96, -0.29),
                          colors: [
                            Color(0xFF58E0FF),
                            Color(0xFF727DCD),
                            Color(0xFFCE01D2)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 3,
                            color: Get.isDarkMode ? bgContainer : lightbgColor,
                          ),
                          borderRadius: BorderRadius.circular(45),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: White,
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  body: SafeArea(
                    child: Stack(
                      children: [
                        Column(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                          dynamicColor:
                                              controller.chatLength > 0,
                                          bgColor: Get.isDarkMode
                                              ? lightbgColor
                                              : Colors.black),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                              .then((value) =>
                                                  controller.getAppUser());
                                        },
                                        image:
                                            'assets/images/person_setting.svg',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                        Positioned(
                          bottom: 50,
                          left: 110,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Visibility(
                              visible: _smallButtonsVisible,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: [
                                    AddPostbutton(
                                      title: 'Add Post'.tr,
                                      onPressed: () {
                                        _smallButtonsVisible = false;
                                        setState(() {});
                                        Get.toNamed(AppRoutes.addpost);
                                      },
                                      selected: false,
                                      buttonWidth: 0.4,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AddPostbutton(
                                      title: 'Add Story'.tr,
                                      onPressed: () {
                                        _smallButtonsVisible = false;
                                        setState(() {});
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (BuildContext builder) {
                                            return Container(
                                              width: double.infinity,
                                              // You can customize the appearance of your bottom sheet here
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                topRight: Radius
                                                                    .circular(
                                                                        5))),
                                                      ),
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size(
                                                                  double
                                                                      .infinity,
                                                                  50)),
                                                    ),
                                                    onPressed: () {
                                                      _smallButtonsVisible =
                                                          false;
                                                      setState(() {});
                                                      controller
                                                          .selectStoryImage();
                                                    },
                                                    child: Text(
                                                      'Camera'.tr,
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff0f0a06),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: double.infinity,
                                                      color: bgContainer
                                                          .withOpacity(0.45),
                                                      height: 0.5),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0))),
                                                      ),
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size(
                                                                  double
                                                                      .infinity,
                                                                  50)),
                                                    ),
                                                    onPressed: () async {
                                                      _smallButtonsVisible =
                                                          false;
                                                      setState(() {});
                                                      controller
                                                          .selectStoryMp4();
                                                    },
                                                    child: Text(
                                                      'Video'.tr,
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff0f0a06),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      width: double.infinity,
                                                      color: bgContainer
                                                          .withOpacity(0.45),
                                                      height: 0.5),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0))),
                                                      ),
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size(
                                                                  double
                                                                      .infinity,
                                                                  50)),
                                                    ),
                                                    onPressed: () async {
                                                      if (await getpermission() ==
                                                          true)
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Directionality(
                                                                          textDirection:
                                                                              TextDirection.ltr,
                                                                          child: StoriesEditor(
                                                                              // onBackPress:Future<false>(){

                                                                              // },
                                                                              discardEdit: 'Discard Edits?'.tr,
                                                                              cancel: 'Cancel'.tr,
                                                                              discard: 'Discard'.tr,
                                                                              title: "If you go back now, you'll lose all the edits you've made.".tr,
                                                                              onDoneButtonStyle: Container(
                                                                                padding: EdgeInsets.all(4),
                                                                                child: StoryButton(
                                                                                  title: "Upload".tr,
                                                                                  selected: true,
                                                                                ),
                                                                              ),
                                                                              middleBottomWidget: Image.asset('assets/images/logo.png'),
                                                                              editorBackgroundColor: Colors.transparent,
                                                                              giphyKey: 'Hgi0RY0dhM2Bz9uSH1M95f9cRYhzpOZE',
                                                                              onDone: (uri) {
                                                                                _smallButtonsVisible = false;
                                                                                setState(() {});
                                                                                controller.addStory(uri);
                                                                              }),
                                                                        )));
                                                    },
                                                    child: Text(
                                                      'Gallery or Text'.tr,
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff0f0a06),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                      ),
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size(
                                                                  double
                                                                      .infinity,
                                                                  50)),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Cancel'.tr,
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff0f0a06),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      // onPressed: (){
                                      //   controller.selectStoryImage();
                                      // },
                                      // onPressed: () async {

                                      // },
                                      selected: false,
                                      type: 'story',
                                      buttonWidth: 0.4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
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
