// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/promocode/promoCode_controller.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key});

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromoCodeContoller>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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
                        color: white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, bottom: 110, right: 108, top: 30),
                        child: Text(
                          'My Promo Code.',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.94,
                    height: 250,
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 22, 22, 22),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 44, 42, 42),
                          offset: Offset(0.0, 0.0),
                          blurRadius: 4.0,
                          spreadRadius: 4.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Column(
                      children: [
                        InputField(
                          lable: 'Promo name',
                          controller: controller.nameController,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        InputField(
                          lable: 'discount percentage',
                          controller: controller.percentagecontroller,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SvgPicture.asset('assets/images/Vector (1).svg'),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Text('Promo Code Added Successfully'),
                  //   ],
                  // ),
                  SizedBox(
                    height: 150,
                  ),
                    GradientButton(
                          title: 'Save Changes',
                          onPressed: controller.areFieldsFilled.value
                              ? () {
                                  controller.storePromocode();
                                }
                              : () {
                                  UiUtilites.errorSnackbar(
                                      'Fill out all fields',
                                      'Please fill all above fields');
                                },
                          selected: controller.areFieldsFilled.value,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
