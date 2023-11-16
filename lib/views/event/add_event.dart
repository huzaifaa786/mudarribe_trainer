import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/components/button.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/inputfieldopicity.dart';
import 'package:mudarribe_trainer/components/inputfieldprice.dart';
import 'package:mudarribe_trainer/components/inputfieldtime.dart';
import 'package:mudarribe_trainer/components/smallbutton.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          TopBar(text: 'Add Event'),
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
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
                          GradientText('Upload Event Photo',
                              style: TextStyle(
                                  fontSize: 14.0, fontFamily: "Poppins"),
                              colors: [borderbottom, borderTop]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("Event Title",
                          style: TextStyle(
                            color: white.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    InputField(),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Date',
                          style: TextStyle(
                            color: white.withOpacity(0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    InputField(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputFieldTime(text: 'from'),
                        InputFieldTime(text: 'to')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputFieldPrice(text: 'Price'),
                        InputFieldOpicity(text: 'Opacity')
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
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
                            margin: EdgeInsets.only(top: 5),
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
                                  padding: EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      'assets/images/selectgooglemapicon.png'),
                                ),
                                GradientText('Select From Google Map',
                                    style: TextStyle(
                                        fontSize: 14.0, fontFamily: "Poppins"),
                                    colors: [borderbottom, borderTop]),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Text(
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
                                    style: TextStyle(
                                        fontSize: 14.0, fontFamily: "Poppins"),
                                    colors: [borderbottom, borderTop]),
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
                                    style: TextStyle(
                                        fontSize: 14.0, fontFamily: "Poppins"),
                                    colors: [borderbottom, borderTop]),
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
