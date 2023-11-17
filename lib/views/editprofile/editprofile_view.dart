// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/values/color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      ),
                      Positioned(
                        bottom: 23,
                        right: 17,
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          // fillColor: Color(0xFFF5F6F9),
                          // ignore: sort_child_properties_last
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.blue,
                            size: 39,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Choose photo',
                    style: TextStyle(color: White),
                  ),
                ),
                InputField(
                  lable: 'Name',
                ),
                BioInputField(
                  lable: 'Bio',
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: SvgPicture.asset(
                        'assets/images/iconamoon_discount.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Text(
                      " Promo Code",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..shader = LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(4285693389),
                                  Color(4284015103)
                                ]).createShader(Rect.fromLTWH(0, 0, 200, 20))),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: SvgPicture.asset(
                        'assets/images/mdi_password-outline.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Text(
                      " Change Password",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..shader = LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(4285693389),
                                  Color(4284015103)
                                ]).createShader(Rect.fromLTWH(0, 0, 200, 20))),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                      child: SvgPicture.asset(
                        'assets/images/Vector.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Text(
                      " Log out",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          foreground: Paint()
                            ..shader = LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(4285693389),
                                  Color(4284015103)
                                ]).createShader(Rect.fromLTWH(0, 0, 200, 20))),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                GradientButton(
                  title: 'Save Changes',
                  onPressed: () {
                   
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
