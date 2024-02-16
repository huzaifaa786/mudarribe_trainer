// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/values/color.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key, this.text, this.ontap, this.file}) : super(key: key);
  final text;
  final ontap;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  foreground: Paint()
                    ..shader = LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [Color(4285693389), Color(4284015103)])
                        .createShader(Rect.fromLTWH(0, 0, 200, 20))),
            ),
            SizedBox(
              height: 16,
            ),
            file == null
                ? IconButtons(title: 'Upload'.tr, onPressed: ontap)
                : Row(
                    children: [
                      SvgPicture.asset('assets/images/doc.svg'),
                      // Icon(Icons.document_scanner),
                      Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(file!.path.split('/').last,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 24 / 16,
                              )),
                          Text(
                              '${(file!.lengthSync() / 1024).toStringAsFixed(2)} KB',
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 15 / 10,
                              )),
                        ],
                      ),
                    ],
                  )
          ],
        ),
        decoration: BoxDecoration(
           color:  Get.isDarkMode? bgContainer: Colors.grey.withOpacity(0.2) ,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
