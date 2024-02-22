// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/views/sale/sale_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mudarribe_trainer/values/color.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleController>(
      initState: (state) async {
        Future.delayed(Duration(milliseconds: 100), () {
          state.controller!.fetchSale(FirebaseAuth.instance.currentUser!.uid);
        });
      },
      builder: (controller) => Directionality(            textDirection: TextDirection.ltr,

        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            title: TopBar(
              text: 'My Sales'.tr,
            ),
          ),
          body: BusyIndicator(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TableCalendar(
                              selectedDayPredicate: (day) =>
                                  isSameDay(day, controller.today),
                              firstDay: DateTime.utc(2023, 1, 1),
                              lastDay: DateTime.now(),
                              focusedDay: controller.today,
                              rangeStartDay: controller.rangeStart,
                              rangeEndDay: controller.rangeEnd,
                              rangeSelectionMode: RangeSelectionMode.enforced,
                              // onDaySelected: saleController.onDaySelected,
                              onRangeSelected: controller.onRangeSelected,
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                                titleTextStyle: TextStyle(
                                    color: Color.fromARGB(255, 56, 125, 181),
                                    fontSize: 23),
                              ),
                              calendarStyle: CalendarStyle(
                                // we
                                defaultTextStyle:
                                     TextStyle(color:  Get.isDarkMode? white: maincolor ,),
                                todayDecoration: BoxDecoration(
                                    color: borderTop.withOpacity(0.5),
                                    shape: BoxShape.circle),
                                selectedDecoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      borderTop,
                                      borderTop,
                                      borderbottom
                                    ]),
                                    shape: BoxShape.circle),
                                markerDecoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                rangeStartDecoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      borderTop,
                                      borderTop,
                                      borderbottom
                                    ]),
                                    shape: BoxShape.circle),
                                rangeEndDecoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [borderbottom, borderTop]),
                                    shape: BoxShape.circle),
                                rangeHighlightColor: borderTop.withOpacity(0.2),
                                isTodayHighlighted: true,
                                outsideDaysVisible: false,
                              ),
                              availableCalendarFormats: const {
                                CalendarFormat.month: 'Month',
                                // CalendarFormat.week: 'Week',
                              },
                              onPageChanged: controller.onFormatChanged,
                              calendarFormat: controller.format,
                              onFormatChanged: (CalendarFormat format) {
                                setState(() {
                                  format == CalendarFormat.week
                                      ? controller.format1 = 'week'
                                      : controller.format1 = 'month';
                                  controller.format = format;
                                  controller.getsale();
                                });
                              },
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              daysOfWeekVisible: true,
            
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                                weekendStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Column(
                                children: [
                                  Text('Total Sales'.tr,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: white))
                                       ,
                                  SizedBox(height: 30),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    decoration: BoxDecoration(
                                        color:Get.isDarkMode ?
                                            const Color.fromARGB(255, 79, 75, 75)
                                                .withOpacity(0.2) : lightbgColor,
                                        borderRadius: BorderRadius.circular(13)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${controller.sum} '+' AED'.tr,
                                          style: new TextStyle(
                                              fontSize: 29.0,
                                              fontWeight: FontWeight.bold,
                                              foreground: Paint()
                                                ..shader = LinearGradient(
                                                  colors: <Color>[
                                                    borderTop,
                                                    borderTop,
                                                    borderTop,
                                                    borderbottom
                                                  ],
                                                ).createShader(Rect.fromLTWH(
                                                    0.0, 0.0, 250.0, 70.0))),
                                        ) 
                                        // GradientText2(
                                        //   text: '${controller.sum} AED',
                                        //   size: 29.0,
                                        // ),
                                        ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
