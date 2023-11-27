// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/components/packagebox.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          title: TitleTopBar(
            name: 'Packages',
            ontap: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                PackageCard(
                  ontap: (){
                    Get.toNamed(AppRoutes.editplan);
                  },
                ),
                PackageCard(
                  ontap: (){
                    Get.toNamed(AppRoutes.editplan);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.addplan);
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [borderTop, borderbottom]),
                              width: 1.5,
                            ),
                          ),
                          padding: EdgeInsets.all(25),
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: borderbottom,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: GradientText(
                            'Add New Package',
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            colors: [borderTop, borderbottom],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
