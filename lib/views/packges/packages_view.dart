// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/packagebox.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/packges/package_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
      builder: (controller) => controller.currentUser != null
          ? BusyIndicator(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                    appBar: AppBar(
                      forceMaterialTransparency: true,
                      automaticallyImplyLeading: false,
                      title: TitleTopBar(
                        name: 'Packages'.tr,
                        ontap: () {
                          Get.back();
                        },
                      ),
                    ),
                    bottomNavigationBar: SizedBox(
                      height: 75,
                      width: double.infinity,
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.addplan)!.then((value) {
                          controller.getAppUser();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode ? maincolor : white,
                                shape: BoxShape.circle),
                            child: Container(
                              padding: EdgeInsets.all(6),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Get.isDarkMode ? maincolor : white,
                                  borderRadius: BorderRadius.circular(40),
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                        colors: [borderTop, borderbottom],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomLeft),
                                    width: 4,
                                  )),
                              child: Icon(
                                Icons.add,
                                color: borderbottom,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GradientText2(
                              text: 'Add New Package'.tr,
                            ),
                          )
                        ],
                      ),
                    ),
                    body: SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            Flexible(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.88,
                                padding: EdgeInsets.only(left: 12, right: 12),
                                child: controller.packages.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: controller.packages.length,
                                        itemBuilder: (context, index) =>
                                            PackageCard(
                                              image: controller
                                                  .packages[index].category,
                                              ontap: () {
                                                Get.toNamed(AppRoutes.editplan,
                                                        arguments: controller
                                                            .packages[index]
                                                            .id)!
                                                    .then((value) => controller
                                                        .getTrainerPackages());
                                              },
                                              onPressed: () {
                                                // String id =
                                                //     controller.packages[index].id;

                                                // UiUtilites.confirmAlert(context,
                                                //     'Are you sure you want to delete this package?',
                                                //     () {
                                                //   controller.deletePackageById(id);
                                                // }, () {
                                                //   Get.back();
                                                // }, 'Yes', 'Cancel');
                                              },
                                              name: controller
                                                  .packages[index].name,
                                              discription: controller
                                                  .packages[index].discription,
                                              price: controller
                                                  .packages[index].price,
                                            ))
                                    : Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.88,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                            left: 12, right: 12),
                                        child: Center(
                                          child: Text(
                                            "no package found yet".tr,
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            // Padding(

                            //   padding:
                            //       const EdgeInsets.only(top: 30, bottom: 30),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Get.toNamed(AppRoutes.addplan)!.then((value) {
                            //         controller.getAppUser();
                            //       });
                            //     },
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(90),
                            //             border: const GradientBoxBorder(
                            //               gradient: LinearGradient(colors: [
                            //                 borderTop,
                            //                 borderbottom
                            //               ]),
                            //               width: 1.5,
                            //             ),
                            //           ),
                            //           padding: EdgeInsets.all(25),
                            //           child: Icon(
                            //             Icons.add,
                            //             size: 30,
                            //             color: borderbottom,
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.only(top: 12.0),
                            //           child: GradientText2(
                            //             text: 'Add New Package'.tr,
                            //             size: 14.0,
                            //             weight: FontWeight.w600,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )),
              ),
            )
          : BasicLoader(),
    );
  }
}
