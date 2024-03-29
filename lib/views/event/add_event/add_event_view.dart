// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_translator/google_translator.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/event_inputfield.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  Future<bool> getpermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Permission.location;
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      permission = await Geolocator.requestPermission();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition();
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return GetBuilder<AddEventContoller>(
      builder: (controller) => BusyIndicator(
        child: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              forceMaterialTransparency: true,
              title: TitleTopBar(
                name: 'Add Events'.tr,
                ontap: () {
                  Get.back();
                },
              ),
            ),
            body: Directionality(
              textDirection: box.read('locale') == 'ar'
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
              child: SafeArea(
                  child: Form(
                key: controller.formKey,
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
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
                                          // fit: BoxFit.fill,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/heroicon.png'),
                                            GradientText2(
                                              text: 'Upload Event Photo'.tr,
                                              size: 11.0,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 4, left: 4, right: 4),
                                child: Text("Event Title".tr,
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? white.withOpacity(0.45)
                                          : maincolor,
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                              EventInputField(
                                controller: controller.eventTitleController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Scheduleinput(
                                    text: 'From Date'.tr,
                                    controller: controller.dateController,
                                    width: 1.0,
                                    onpressed: () {
                                      picker.DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onChanged: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var date =
                                            DateFormat('dd/MM/y').format(val);
                                        controller.dateController.text = date;
                                        controller.checkFields();
                                      }, onConfirm: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var date =
                                            DateFormat('dd/MM/y').format(val);
                                        controller.dateController.text = date;
                                        controller.checkFields();
                                      }, currentTime: DateTime.now());
                                    },
                                    hint: DateFormat('dd/MM/y')
                                        .format(DateTime.now()),
                                    fontSize: 18.0,
                                  ),
                                  Scheduleinput(
                                    text: 'To Date'.tr,
                                    controller: controller.todateController,
                                    width: 1.0,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onpressed: () {
                                      picker.DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onChanged: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var date =
                                            DateFormat('dd/MM/y').format(val);
                                        controller.todateController.text = date;
                                        controller.checkFields();
                                      }, onConfirm: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var date =
                                            DateFormat('dd/MM/y').format(val);
                                        controller.todateController.text = date;
                                        controller.checkFields();
                                      }, currentTime: DateTime.now());
                                    },
                                    hint: DateFormat('dd/MM/y')
                                        .format(DateTime.now()),
                                    fontSize: 18.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Scheduleinput(
                                    text: 'From'.tr,
                                    controller: controller.startTimeController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onpressed: () {
                                      picker.DatePicker.showTime12hPicker(
                                          context,
                                          showTitleActions: true,
                                          onChanged: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var time =
                                            DateFormat('hh:mm a').format(val);

                                        controller.startTimeController.text =
                                            time;

                                        controller.checkFields();

                                        setState(() {});
                                      }, onConfirm: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var time =
                                            DateFormat('hh:mm a').format(val);
                                        controller.startTimeController.text =
                                            time;
                                        controller.checkFields();

                                        setState(() {});
                                      }, currentTime: DateTime.now());
                                    },
                                    hint: '9:00 am',
                                    fontSize: 18.0,
                                  ),
                                  Scheduleinput(
                                    text: 'to'.tr,
                                    controller: controller.endTimeController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onpressed: () {
                                      picker.DatePicker.showTime12hPicker(
                                          context,
                                          showTitleActions: true,
                                          onConfirm: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var end =
                                            DateFormat('hh:mm a').format(val);
                                        controller.endTimeController.text = end;
                                        controller.checkFields();
                                      }, onChanged: (val) {
                                        controller.formKey.currentState!
                                            .validate();
                                        var end =
                                            DateFormat('hh:mm a').format(val);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 4,
                                            left: 4,
                                            right: 4),
                                        child: Text("Price".tr,
                                            style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? white.withOpacity(0.45)
                                                  : maincolor,
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: PriceInputWithoutLabel(
                                            type: TextInputType.number,
                                            controller:
                                                controller.priceController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '';
                                              }

                                              return null;
                                            },
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 4,
                                            left: 4,
                                            right: 4),
                                        child: Text("Capacity".tr,
                                            style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? white.withOpacity(0.45)
                                                  : maincolor,
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: EventInputField(
                                            controller:
                                                controller.capacityController,
                                            type: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
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
                                    Text("Location".tr,
                                        style: TextStyle(
                                          color: Get.isDarkMode
                                              ? white.withOpacity(0.45)
                                              : maincolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    InkWell(
                                      onTap: () async {
                                        if (await getpermission() == true) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PlacePicker(
                                                apiKey:
                                                    "AIzaSyBOr3bXgN2bj9eECzSudyj_rgIFjyXkdn8",
                                                onPlacePicked: (result) {
                                                  controller.address =
                                                      result.formattedAddress!;

                                                  Navigator.of(context).pop();
                                                  setState(() {});

                                                  controller.checkFields();
                                                },
                                                initialPosition:
                                                    LatLng(25.1972, 55.2744),
                                                useCurrentLocation: true,
                                                resizeToAvoidBottomInset:
                                                    false, // only works in page mode, less flickery, remove if wrong offsets
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            border: const GradientBoxBorder(
                                              gradient: LinearGradient(colors: [
                                                borderbottom,
                                                borderTop
                                              ]),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: controller.address.isEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.asset(
                                                        'assets/images/selectgooglemapicon.png'),
                                                  ),
                                                  GradientText2(
                                                      text:
                                                          'Select From Google Map'
                                                              .tr,
                                                      size: 14.0),
                                                ],
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GradientText(
                                                    controller.address,
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
                                        child: Text(
                                            "Would you like your event to be in\nthe Banner?"
                                                .tr,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? white
                                                  : maincolor,
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: GradientText('Yes'.tr,
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Poppins"),
                                                colors: [
                                                  borderbottom,
                                                  borderTop
                                                ]),
                                            leading: Radio(
                                                fillColor: MaterialStateColor
                                                    .resolveWith(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .selected)) {
                                                      return borderbottom;
                                                    }
                                                    return borderbottom;
                                                  },
                                                ),
                                                value: 1,
                                                groupValue:
                                                    controller.selectedOption,
                                                onChanged: controller.value),
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                                20), // Add some space between the two options
                                        Expanded(
                                          child: ListTile(
                                            title: GradientText('No'.tr,
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Poppins"),
                                                colors: [
                                                  borderbottom,
                                                  borderTop
                                                ]),
                                            leading: Radio(
                                              fillColor: MaterialStateColor
                                                  .resolveWith(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.selected)) {
                                                    return borderbottom;
                                                  }
                                                  return borderbottom;
                                                },
                                              ),
                                              value: 2,
                                              groupValue:
                                                  controller.selectedOption,
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
                                      title: 'Share Event'.tr,
                                      selected:
                                          controller.areFieldsFilled.value,
                                      onPressed: () {
                                        controller.areFieldsFilled.value == true
                                            ? controller.addEvent()
                                            : UiUtilites.errorSnackbar(
                                                "Fill out all fields".tr, '');
                                      })
                                  : GradientButton(
                                      title: 'Checkout'.tr,
                                      selected:
                                          controller.areFieldsFilled.value,
                                      onPressed: () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.areFieldsFilled.value ==
                                                  true
                                              ? controller.addEvent()
                                              : UiUtilites.errorSnackbar(
                                                  "Fill out all fields".tr, '');
                                        }
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
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
