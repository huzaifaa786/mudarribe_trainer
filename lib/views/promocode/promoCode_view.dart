// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/large_button.dart';
import 'package:mudarribe_trainer/values/color.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key});

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
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
                  InputField(
                    lable: 'Promo name',
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  InputField(
                    lable: 'discount percentage',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/Vector (1).svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Promo Code Added Successfully'),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  GradientButton(
                    title: 'Confirm',
                    onPressed: () {},
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
