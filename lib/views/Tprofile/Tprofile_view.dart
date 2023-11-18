// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/Tprofile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

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
        builder: (controller) => Scaffold(
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
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(50, 1000, 0, 50),
                    items: [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.add),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.remove),
                        ),
                      ),
                      // Add more PopupMenuItems as needed
                    ],
                  );
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 30, 29, 29),
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
                                    child: Image.asset(
                                        'assets/images/profile.png',
                                        fit: BoxFit.fill),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Salim Ahmed',
                                          style: TextStyle(
                                              color: White,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7),
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
                                        'Body Building& lifting trainer',
                                        style: TextStyle(
                                            color: profilesubheading,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        'Body Building & lifting  trainer, let me help you to get your dream body!  ',
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
                            itemCount: controller.gridItems.length,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                controller.gridItems[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
