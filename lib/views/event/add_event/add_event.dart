import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/inputfieldopicity.dart';
import 'package:mudarribe_trainer/components/inputfieldprice.dart';
import 'package:mudarribe_trainer/components/inputfieldtime.dart';
import 'package:mudarribe_trainer/components/schedule.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:intl/intl.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedOption = 1;
   final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 50, top: 50),
                      decoration: BoxDecoration(
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                                colors: [borderbottom, borderTop]),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/heroicon.png'),
                          GradientText(
                            'Upload Event Photo',
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                            colors: const [borderbottom, borderTop],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("Event Title",
                          style: TextStyle(
                            color: white.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    const InputField(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text('Date',
                          style: TextStyle(
                            color: white.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    const InputField(),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InputFieldTime(text: 'from'),
                    //     InputFieldTime(text: 'to')
                    //   ],
                    // ),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InputFieldPrice(text: 'Price'),
                    //     InputFieldOpicity(text: 'Opacity')
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Scheduleinput(
                          text: 'Start Time'.tr,
                          controller: startTimeController,
                          onpressed: () {
                            DatePicker.showTimePicker(context,
                                showTitleActions: true,
                                showSecondsColumn: false, onChanged: (val) {
                              var end = val.add(Duration(minutes: 1));
                              var time = DateFormat.Hm().format(val);
                              var endTime = DateFormat.Hm().format(end);
                              // startTimeController.text = time;
                              // endTimeController.text = endTime;
                              // controller.startTime = time;
                              // controller.endTime = endTime;
                              // translatorProfileController
                              //     .calTotalTime(widget.detail!);
                              setState(() {});
                            }, onConfirm: (val) {
                              var end = val.add(Duration(minutes: 1));
                              var time = DateFormat.Hm().format(val);
                              var endTime = DateFormat.Hm().format(end);
                              // startTimeController.text = time;
                              // endTimeController.text = endTime;
                              // controller.startTime = time;
                              // controller.endTime = endTime;
                              // translatorProfileController
                              //     .calTotalTime(widget.detail!);
                              setState(() {});
                            }, currentTime: DateTime.now());
                          },
                          hint: '9:00',
                          fontSize: 18.0,
                        ),
                        Text("To".tr),
                        Scheduleinput(
                          text: 'End Time'.tr,
                          controller: endTimeController,
                          onpressed: () {
                            DatePicker.showTimePicker(context,
                                showTitleActions: true,
                                showSecondsColumn: false, onConfirm: (val) {
                              var end = DateFormat.Hm().format(val);
                              // endTimeController.text = end;
                              // controller.endTime = end;
                              // translatorProfileController
                              //     .calTotalTime(widget.detail!);
                              setState(() {});
                            }, onChanged: (val) {
                              var end = DateFormat.Hm().format(val);
                              // endTimeController.text = end;
                              // controller.endTime = end;
                              // translatorProfileController
                              //     .calTotalTime(widget.detail!);
                              setState(() {});
                            }, currentTime: DateTime.now());
                          },
                          hint: '9:30',
                          fontSize: 18.0,
                          // enabled: controller.startTime == '' ? false : true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location",
                              style: TextStyle(
                                color: white.withOpacity(0.4),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.10,
                            decoration: BoxDecoration(
                                border: const GradientBoxBorder(
                                  gradient: LinearGradient(
                                      colors: [borderbottom, borderTop]),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      'assets/images/selectgooglemapicon.png'),
                                ),
                                GradientText('Select From Google Map',
                                    style: const TextStyle(
                                        fontSize: 14.0, fontFamily: "Poppins"),
                                    colors: const [borderbottom, borderTop]),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: const Text(
                                  "Would you like your event to be in\nthe Banner?",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                          Column(
                            //: MainAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: GradientText('Yes',
                                    style: const TextStyle(
                                        fontSize: 14.0, fontFamily: "Poppins"),
                                    colors: const [borderbottom, borderTop]),
                                leading: Radio(
                                  value: 1,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: GradientText('No',
                                    style: const TextStyle(
                                        fontSize: 14.0, fontFamily: "Poppins"),
                                    colors: const [borderbottom, borderTop]),
                                leading: Radio(
                                  value: 2,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
