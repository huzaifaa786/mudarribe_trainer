// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_adjacent_string_concatenation

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/values/color.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      this.userName,
      this.id,
      this.fromDate,
      this.toDate,
      this.expire,
      this.seen,
      this.sent,
      this.profileImage,
      this.onTapMessage,
      this.onTapSendPlan,
      this.packageName,
      this.duration,
      this.price});

  final userName;
  final id;
  final profileImage;
  final onTapMessage;
  final fromDate;
  final toDate;
  final expire;
  final onTapSendPlan;
  final packageName;
  final price;
  final duration;
  final seen;
  final sent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Get.isDarkMode ? bgContainer : Color(4294375158),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      profileImage == ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(45),
                              child: Image.asset(
                                'assets/images/person.png',
                                height: 35,
                                width: 35,
                                color: Colors.grey,
                              ),
                            )
                          : CircleAvatar(
                            backgroundColor: bgcontainer1,
                              radius: 18,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: Image.network(
                                    profileImage,
                                    height: 36,
                                    width: 36,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: Get.width * 0.5),
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Text(
                              id,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: Get.width * 0.5),
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Text(
                              userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      seen == false
                          ? Container(
                              padding: EdgeInsets.only(left: 6, right: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.red)),
                              child: Text('New',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)))
                          : SizedBox()
                    ],
                  ),
                  InkWell(
                      onTap: onTapMessage,
                      child: SvgPicture.asset(
                        'assets/images/chat.svg',
                        color: Get.isDarkMode ? Colors.white : maincolor,
                      )),
                ],
              ),
              Row(
                children: [
                  GradientText2(
                    text: 'Package'.tr + ':',
                    size: 12.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      packageName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GradientText2(
                        text: 'Price'.tr + ':',
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            price + ' AED'.tr,
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  sent == true ? Text('✅') : Container(),
                ],
              ),
              Row(
                children: [
                  GradientText2(
                    text: 'Duration'.tr + ':',
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '$duration'.tr,
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ))
                ],
              ),
              Gap(4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GradientText2(
                        text: 'Expiry date'.tr + ':',
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            '$fromDate ' + 'to'.tr + ' $toDate',
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  expire == true
                      ? InkWell(
                          onTap: onTapSendPlan,
                          child: GradientText2(
                            text: 'Send Plan'.tr,
                            size: 16.0,
                            weight: FontWeight.w700,
                          ),
                        )
                      : GradientText2(
                          text: 'Ended'.tr,
                          size: 16.0,
                          weight: FontWeight.w700,
                        ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 22,
          left: 11,
          child: Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [borderTop, borderbottom])),
            // color: borderbottom,
          ),
        ),
      ],
    );
  }
}
