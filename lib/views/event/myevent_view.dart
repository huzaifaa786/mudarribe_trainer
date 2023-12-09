// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/eventdetailcard.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';

import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/event/myevent_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
    return GetBuilder<MyEventController>(
        builder: (controller) => controller.currentUser != null
            ? BusyIndicator(
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    forceMaterialTransparency: true,
                    title: TitleTopBar(
                      name: 'My Events',
                      ontap: () {
                        Get.back();
                      },
                    ),
                  ),
                  bottomNavigationBar: SizedBox(
                    height: 75,
                    width: double.infinity,
                  ),
                  floatingActionButton: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.addevent)!
                          .then((value) => controller.getTrainerEvents());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.black,
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
                              color: borderbottom,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GradientText2(
                            text: 'Add New Event',
                          ),
                        )
                      ],
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  body: SingleChildScrollView(
                    child: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        children: [
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
                                      image: NetworkImage(controller
                                          .currentUser!.profileImageUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: Text(
                                  controller.currentUser!.name!,
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
                          SizedBox(height: 8),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.events.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return EventDetailsCard(
                                    onPressClose: () {
                                      UiUtilites.confirmAlert(context,
                                          'Are you sure you want to close this event?',
                                          () {
                                        controller.closeEvent(
                                            controller.events[index]);
                                      }, () {
                                        Get.back();
                                      }, 'Yes', 'Cancel');
                                    },
                                    attendees: 0,
                                    title: controller.events[index].title,
                                    imageUrl: controller.events[index].imageUrl,
                                    onPressDelete: () {
                                      UiUtilites.confirmAlert(context,
                                          'Are you sure you want to delete this event?',
                                          () {
                                        controller.deleteEvent(
                                            controller.events[index]);
                                      }, () {
                                        Get.back();
                                      }, 'Yes', 'Cancel');
                                    },
                                    isClose:
                                        controller.events[index].eventStatus ==
                                                EventStatus.closed
                                            ? true
                                            : false,
                                    address: controller.events[index].address,
                                    startTime:
                                        controller.events[index].startTime,
                                    endTime: controller.events[index].endTime,
                                    date: controller.events[index].date,
                                    price: controller.events[index].price,
                                    capacity: controller.events[index].capacity,
                                    eventStatus:
                                        controller.events[index].eventStatus);
                              })
                        ],
                      ),
                    )),
                  ),
                ),
              )
            : BasicLoader());
  }
}
