import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/values/controller.dart';
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
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      'My Sale',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TableCalendar(
                      selectedDayPredicate: (day) =>
                          isSameDay(day, saleController.today),
                      firstDay: DateTime.utc(2023, 1, 1),
                      lastDay: DateTime.now(),
                      focusedDay: saleController.today,
                      rangeStartDay: saleController.rangeStart,
                      rangeEndDay: saleController.rangeEnd,
                      rangeSelectionMode: RangeSelectionMode.enforced,
                      // onDaySelected: saleController.onDaySelected,
                      onRangeSelected: saleController.onRangeSelected,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                            color: const Color.fromARGB(255, 56, 125, 181),
                            fontSize: 23),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(color: Colors.white),
                        todayDecoration: BoxDecoration(
                            color: borderTop.withOpacity(0.5),
                            shape: BoxShape.circle),
                        selectedDecoration: BoxDecoration(
                            color: borderTop, shape: BoxShape.circle),
                        markerDecoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        rangeStartDecoration: BoxDecoration(
                            color: borderTop, shape: BoxShape.circle),
                        rangeEndDecoration: BoxDecoration(
                            color: borderTop, shape: BoxShape.circle),
                        rangeHighlightColor: borderTop.withOpacity(0.2),
                        isTodayHighlighted: true,
                        outsideDaysVisible: false,
                      ),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        // CalendarFormat.week: 'Week',
                      },
                      onPageChanged: saleController.onFormatChanged,
                      calendarFormat: saleController.format,
                      onFormatChanged: (CalendarFormat format) {
                        setState(() {
                          format == CalendarFormat.week
                              ? saleController.format1 = 'week'
                              : saleController.format1 = 'month';
                          saleController.format = format;
                        });
                      },
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekVisible: true,

                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.white),
                        weekendStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text('Total Sales',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: white)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 40, bottom: 40),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 79, 75, 75)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(13)),
                      child: Align(
                          alignment: Alignment.center,
                          child: GradientText2(
                            text: 'AED',
                            size: 29.0,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
