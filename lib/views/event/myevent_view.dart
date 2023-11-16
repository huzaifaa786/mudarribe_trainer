// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:mudarribe_trainer/components/eventdetailcard.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/values/color.dart';

import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({super.key});

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> with TickerProviderStateMixin {
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
    return Scaffold(
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
        tabBarHeight: 70,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 40, 38, 38),
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Color.fromARGB(255, 40, 38, 38),
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Color.fromARGB(255, 40, 38, 38),
        tabIconSelectedColor: Color.fromARGB(255, 40, 38, 38),
        tabBarColor: Color.fromARGB(255, 40, 38, 38),
        // onTabItemSelected: (int value) {
        //   // setState(() {
        //   //   // _tabController!.index = value;
        //   //   _motionTabBarController!.index = value;
        //   // });
        // },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(
                        colors: [borderTop, borderbottom],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft),
                    width: 4,
                  )),
              child: Icon(
                Icons.add,
                color: White,
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GradientText2(
                text: 'Add New Event',
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 23,
                ),
                Text(
                  'My Events',
                  style: TextStyle(
                      color: White, fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 184, 66, 186),
                            Color.fromARGB(255, 111, 127, 247),
                          ],
                        ),
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Text(
                    'Salim Ahmed',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            EventDetailsCard(),
            EventDetailsCard(),
          ],
        )),
      ),
    );
  }
}
