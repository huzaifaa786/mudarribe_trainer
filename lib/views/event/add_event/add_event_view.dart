// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/event_inputfield.dart';

import 'package:mudarribe_trainer/components/price_input__without_label.dart';
import 'package:mudarribe_trainer/components/schedule.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:intl/intl.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/event/add_event/add_event_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEventContoller>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: TitleTopBar(
            name: 'Add Events',
            ontap: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          controller.selectEventImage();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          // padding: const EdgeInsets.only(bottom: 50, top: 50),
                          decoration: BoxDecoration(
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(
                                    colors: [borderbottom, borderTop]),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          child: controller.eventImage != null
                              ? Image.file(
                                  controller.eventImage!,
                                  fit: BoxFit.fill,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/heroicon.png'),
                                    GradientText(
                                      'Upload Event Photo',
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      colors: const [borderbottom, borderTop],
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 4, left: 4, right: 4),
                        child: Text("Event Title",
                            style: TextStyle(
                              color: white.withOpacity(0.45),
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      EventInputField(
                        controller: controller.eventTitleController,
                      ),
                      Scheduleinput(
                        text: 'Date',
                        controller: controller.dateController,
                        width: 1.0,
                        onpressed: () {
                          picker.DatePicker.showDatePicker(context,
                              showTitleActions: true, onChanged: (val) {
                            var date = DateFormat('d/M/y').format(val);
                            controller.dateController.text = date;
                            controller.checkFields();
                          }, onConfirm: (val) {
                            var date = DateFormat('d/M/y').format(val);
                            controller.dateController.text = date;
                            controller.checkFields();
                          }, currentTime: DateTime.now());
                        },
                        hint: DateFormat('d/M/y').format(DateTime.now()),
                        fontSize: 18.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Scheduleinput(
                            text: 'From',
                            controller: controller.startTimeController,
                            onpressed: () {
                              picker.DatePicker.showTime12hPicker(context,
                                  showTitleActions: true, onChanged: (val) {
                                var end = val.add(Duration(minutes: 1));
                                var time = DateFormat('hh:mm a').format(val);
                                var endTime = DateFormat('hh:mm a').format(end);
                                controller.startTimeController.text = time;
                                controller.endTimeController.text = endTime;
                                controller.checkFields();

                                setState(() {});
                              }, onConfirm: (val) {
                                var end = val.add(Duration(minutes: 1));
                                var time = DateFormat.Hm().format(val);
                                var endTime = DateFormat.Hm().format(end);
                                controller.startTimeController.text = time;
                                controller.endTimeController.text = endTime;
                                controller.checkFields();

                                setState(() {});
                              }, currentTime: DateTime.now());
                            },
                            hint: '9:00 am',
                            fontSize: 18.0,
                          ),
                          Scheduleinput(
                            text: 'To',
                            controller: controller.endTimeController,
                            onpressed: () {
                              picker.DatePicker.showTime12hPicker(context,
                                  showTitleActions: true, onConfirm: (val) {
                                var end = DateFormat('hh:mm a').format(val);
                                controller.endTimeController.text = end;
                                controller.checkFields();
                              }, onChanged: (val) {
                                var end = DateFormat.Hm().format(val);
                                controller.endTimeController.text = end;
                                controller.checkFields();
                              }, currentTime: DateTime.now());
                            },
                            hint: '9:30 am',
                            fontSize: 18.0,
                            // enabled: controller.startTime == '' ? false : true,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 4, left: 4, right: 4),
                                child: Text("Price",
                                    style: TextStyle(
                                      color: white.withOpacity(0.45),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: PriceInputWithoutLabel(
                                    type: TextInputType.number,
                                    controller: controller.priceController,
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 4, left: 4, right: 4),
                                child: Text("Capacity",
                                    style: TextStyle(
                                      color: white.withOpacity(0.45),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: EventInputField(
                                    controller: controller.capacityController,
                                    type: TextInputType.number,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Location",
                                style: TextStyle(
                                  color: white.withOpacity(0.4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey:
                                          "AIzaSyB8nRxHRnBw9rzrWFcVA45CmtDq7FzLb4A",
                                      onPlacePicked: (result) {
                                        controller.address =
                                            result.formattedAddress!;

                                        Navigator.of(context).pop();
                                        setState(() {});

                                        controller.checkFields();
                                      },
                                      initialPosition: LatLng(23.4241, 53.8478),
                                      useCurrentLocation: true,
                                      resizeToAvoidBottomInset:
                                          false, // only works in page mode, less flickery, remove if wrong offsets
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: const GradientBoxBorder(
                                      gradient: LinearGradient(
                                          colors: [borderbottom, borderTop]),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                child: controller.address.isEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/selectgooglemapicon.png'),
                                          ),
                                          GradientText('Select From Google Map',
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: "Poppins",
                                              ),
                                              colors: const [
                                                borderTop,
                                                borderbottom
                                              ]),
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GradientText(controller.address,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Poppins",
                                            ),
                                            colors: const [
                                              borderTop,
                                              borderbottom
                                            ]),
                                      ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: const Text(
                                    "Would you like your event to be in\nthe Banner?",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: GradientText('Yes',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Poppins"),
                                        colors: [borderbottom, borderTop]),
                                    leading: Radio(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return borderbottom;
                                            }
                                            return borderbottom;
                                          },
                                        ),
                                        value: 1,
                                        groupValue: controller.selectedOption,
                                        onChanged: controller.value),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        20), // Add some space between the two options
                                Expanded(
                                  child: ListTile(
                                    title: GradientText('No',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Poppins"),
                                        colors: [borderbottom, borderTop]),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return borderbottom;
                                          }
                                          return borderbottom;
                                        },
                                      ),
                                      value: 2,
                                      groupValue: controller.selectedOption,
                                      onChanged: controller.value,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      controller.selectedOption == 2
                          ? GradientButton(
                              title: 'Share Event',
                              selected: controller.areFieldsFilled.value,
                              onPressed: () {
                                controller.areFieldsFilled.value == true
                                    ? controller.addEvent()
                                    : null;
                              })
                          : GradientButton(
                              title: 'Checkout',
                              selected: controller.areFieldsFilled.value,
                              onPressed: () {
                                controller.areFieldsFilled.value == true
                                    ? controller.addEvent()
                                    : null;
                              }),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
