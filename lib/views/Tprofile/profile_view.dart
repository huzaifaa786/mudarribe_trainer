// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/components/addpostbutton.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/boxing_trainers_card.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/storyButton.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/Tprofile/profile_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stories_editor/stories_editor.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  bool _smallButtonsVisible = false;

  void toggleSmallButtonsVisibility() {
    setState(() {
      _smallButtonsVisible = !_smallButtonsVisible;
    });
  }

  Future<bool> getpermission() async {
    bool serviceEnabled = false;

    Permission mediaLocation = await Permission.accessMediaLocation;
    Permission permission = await Permission.manageExternalStorage;
    Permission storagepermission = await Permission.storage;
    Permission cameraPermission = await Permission.camera;
    Permission mediaPermission = await Permission.mediaLibrary;
    if (permission.status.isGranted == false &&
        storagepermission.status.isGranted == false &&
        cameraPermission.status.isGranted == false &&
        mediaPermission.status.isGranted == false &&
        mediaLocation.status.isGranted == false) {
      return serviceEnabled;
    } else {
      return serviceEnabled = true;
    }
  }

  @override
  void initState() {
    getpermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => controller.currentUser != null
          ? BusyIndicator(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  appBar: AppBar(
                    forceMaterialTransparency: true,
                    automaticallyImplyLeading: false,
                    title: TitleTopBar(
                      name: '',
                      ontap: () {
                        Get.back();
                      },
                    ),
                  ),
                  bottomNavigationBar: Container(
                    height: 50,
                    color: bgContainer,
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
                          side: BorderSide(width: 3, color: bgContainer),
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
                        // padding: const EdgeInsets.only(left: 15, right: 15),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent.withOpacity(0.0),
                                borderRadius: BorderRadius.circular(20)),
                            // padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 92,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: const GradientBoxBorder(
                                              gradient: LinearGradient(colors: [
                                                Color(0xffc000c3),
                                                borderTop,
                                                borderTop,
                                                borderbottom,
                                                Color(0xff00f8e9),
                                                borderbottom
                                              ]),
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: Image.network(
                                                  controller.currentUser!
                                                      .profileImageUrl!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover),
                                            ),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  controller.currentUser!.name!,
                                                  style: TextStyle(
                                                      color: White,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7),
                                                  child: Image.asset(
                                                    'assets/images/verified_tick.png',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              padding: const EdgeInsets.only(
                                                  top: 2, bottom: 8),
                                              child: Text(
                                                controller
                                                    .currentUser!.categories!
                                                    .join('& '),
                                                style: TextStyle(
                                                    color: profilesubheading,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                controller.currentUser!.bio!,
                                                style: TextStyle(
                                                    color: White,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 10, top: 35),
                                  child: Divider(
                                    thickness: 1,
                                    color: dividercolor,
                                  ),
                                ),
                                Flexible(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                    ),
                                    itemCount: controller.posts.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostCard(
                                                        userimg: controller
                                                            .currentUser!
                                                            .profileImageUrl!,
                                                        username: controller
                                                            .currentUser!.name,
                                                        postdescription:
                                                            controller
                                                                .posts[index]
                                                                .caption!,
                                                        postimg: controller
                                                            .posts[index]
                                                            .imageUrl!,
                                                        postId: controller
                                                            .posts[index].id,
                                                      ))).then((value) =>
                                              controller.getAppUser());
                                        },
                                        child: Image.network(
                                          controller.posts[index].imageUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
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
                                          Get.toNamed(AppRoutes.addpost)!.then(
                                              (value) =>
                                                  controller.getTrainerPosts());
                                        },
                                        selected: false,
                                        buttonWidth: 0.4,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AddPostbutton(
                                        title: 'Add Story'.tr,
                                        onPressed: () async {
                                          if (await getpermission() == true)
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            Directionality(
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr,
                                                              child:
                                                                  StoriesEditor(
                                                                    // onBackPress:Future<false>(){

                                                                    // },
                                                                      onDoneButtonStyle:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(4),
                                                                        child:
                                                                            StoryButton(
                                                                          title:
                                                                              "Upload".tr,
                                                                          selected:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                      middleBottomWidget: Image
                                                                          .asset(
                                                                              'assets/images/logo.png'),
                                                                      editorBackgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      giphyKey:
                                                                          'Hgi0RY0dhM2Bz9uSH1M95f9cRYhzpOZE',
                                                                      onDone:
                                                                          (uri) {
                                                                        controller
                                                                            .addStory(uri);
                                                                      }),
                                                            )));
                                        },
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
                        ]),
                  ),
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}
