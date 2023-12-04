// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/promocode/promoCode_controller.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({Key? key}) : super(key: key);
  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  @override
  Widget build(BuildContext context) {
    String id = Get.arguments;
    return GetBuilder<PromoCodeContoller>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 50,left: 15,right: 15),
                        child: Text(
                          'My Promo code',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      // height: 300,
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top:40, bottom: 70),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 15, 15, 15),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          InputField(
                            lable: 'Promo name',
                            controller: controller.nameController,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          InputField(
                            lable: 'Discount percentage',
                            controller: controller.percentagecontroller,
                          ),
                        ],
                      ),
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
                            controller.id = id;
                            print('object');
                            controller.storePromocode();
                          }
                        : () {
                            UiUtilites.errorSnackbar('Fill out all fields',
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
