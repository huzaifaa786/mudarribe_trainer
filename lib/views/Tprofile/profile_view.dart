// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:mudarribe_trainer/components/addpostbutton.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/Tprofile/addpost_view.dart';
import 'package:mudarribe_trainer/views/Tprofile/profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/stories_editor.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  bool _smallButtonsVisible = false;

  void toggleSmallButtonsVisibility() {
    setState(() {
      _smallButtonsVisible = !_smallButtonsVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (controller) => controller.currentUser != null
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  leading: Icon(
                    Icons.arrow_back_ios_new,
                    color: White,
                  ),
                ),
                bottomNavigationBar: MotionTabBar(
                  controller: _motionTabBarController,
                  initialSelectedTab: "Home",
                  labels: const ["Dashboard", "Home", 'saasd'],
                  icons: const [
                    Icons.dashboard,
                    Icons.add,
                    Icons.people_alt,
                  ],
                  badges: [null, null, null],
                  tabSize: 80,
                  tabBarHeight: 50,
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  tabIconColor: Colors.black,
                  tabIconSize: 28.0,
                  tabIconSelectedSize: 26.0,
                  tabSelectedColor: Colors.black,
                  tabIconSelectedColor: Colors.white,
                  tabBarColor: Colors.black,
                  // onTabItemSelected: (int value) {
                  //   // setState(() {
                  //   //   // _tabController!.index = value;
                  //   //   _motionTabBarController!.index = value;
                  //   // });
                  // },
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
                        side: BorderSide(width: 0, color: Colors.black),
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
                                    left: 10, right: 10, top: 15),
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
                                              Color(0xff727dcd),
                                              Color(0xff00f8e9)
                                            ]),
                                            width: 2,
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
                                      padding: const EdgeInsets.only(left: 12),
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
                                                padding: const EdgeInsets.only(
                                                    left: 7),
                                                child: Image.asset(
                                                  'assets/images/verified_tick.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, bottom: 8),
                                            child: Text(
                                              controller
                                                  .currentUser!.categories!
                                                  .join('& '),
                                              style: TextStyle(
                                                  color: profilesubheading,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
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
                                                  fontWeight: FontWeight.w400),
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
                                  itemCount: controller.posts!.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      controller.posts![index].imageUrl!,
                                      fit: BoxFit.cover,
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
                                      title: 'Add Post',
                                      onPressed: () {
                                        Get.toNamed(AppRoutes.addpost);
                                      },
                                      selected: false,
                                      buttonWidth: 0.4,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AddPostbutton(
                                      title: 'Add Story',
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StoriesEditor(
                                                      onDoneButtonStyle: Container(decoration: BoxDecoration(border: Border.all(color: white)),padding: EdgeInsets.all(4),child: Text('Done'),),
                                                      middleBottomWidget: Image.asset('assets/images/logo.png'),
                                                      giphyKey:
                                                          'Hgi0RY0dhM2Bz9uSH1M95f9cRYhzpOZE',
                                                        
                                                      onDone: (uri) {
                                                        debugPrint(uri);
                                                        // Share.shareFiles([uri]);
                                                      },
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
              )
            : BasicLoader());
  }
}
