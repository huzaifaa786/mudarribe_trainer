import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/meals_card.dart';
import 'package:mudarribe_trainer/components/pdfcard.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/chat/pdf_view.dart';
import 'package:mudarribe_trainer/views/sendplan/existing_plan/existing_plan_controller.dart';
import 'package:mudarribe_trainer/views/video/video_view.dart';

class TodayMealsScreen extends StatefulWidget {
  const TodayMealsScreen({super.key});

  @override
  State<TodayMealsScreen> createState() => _TodayMealsScreenState();
}

class _TodayMealsScreenState extends State<TodayMealsScreen> {
  String title = '02';
  String description = 'Full Body Energy'.tr;
  String imgpath1 = 'assets/images/containimg.jpeg';

  @override
  Widget build(BuildContext context) {
    var planId = Get.parameters['planId'] as String;
    var userId = Get.parameters['userId'] as String;
    var orderId = Get.parameters['orderId'] as String;
    var firebaseToken = Get.parameters['firebaseToken'] as String;
    var category = Get.parameters['category'] as String;
    var trainerName = Get.parameters['trainerName'] as String;

    return GetBuilder<ExistingPlanController>(
      initState: (state) async {
        Future.delayed(const Duration(milliseconds: 100), () {
          state.controller!.planId = planId;
          state.controller!.userId = userId;
          state.controller!.orderId = orderId;
          state.controller!.firebaseToken = firebaseToken;
          state.controller!.trainerName = trainerName;
          state.controller!.category = category;
          state.controller!.getTrainerFiles();
        });
      },
      builder: (controller) => controller.plan != null
          ? BusyIndicator(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  backgroundColor: Colors.black,
                  body: SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopBar(
                        text: controller.plan!.name,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, top: 45),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                IconButtons(
                                    title: 'Upload New Files'.tr,
                                    onPressed: () {
                                      controller.selectmultipleFiles();
                                    }),
                                Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.7,
                                  // width: MediaQuery.of(context).size.width * 0.9,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: controller.planfiles.length,
                                      itemBuilder: (context, index) {
                                        return controller.planfiles[index]
                                                    .fileType ==
                                                FileType.mp4
                                            ? MealsCard(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoPlay(
                                                              path: controller
                                                                  .planfiles[
                                                                      index]
                                                                  .fileUrl),
                                                    ),
                                                  );
                                                },
                                                title: controller
                                                    .planfiles[index].fileName
                                                    .toString(),
                                                description: '',
                                                imgpath1: controller
                                                    .planfiles[index].fileUrl,
                                                futureFunc: controller
                                                    .genrateVideoThumbnail(
                                                        controller
                                                            .planfiles[index]
                                                            .fileUrl),
                                                onDeleteTap: () {
                                                  UiUtilites.confirmAlert(
                                                      context,
                                                      'Are you sure you want to delete this File?'
                                                          .tr, () {
                                                    controller.deleteFile(
                                                        controller
                                                            .planfiles[index]);
                                                  }, () {
                                                    Get.back();
                                                  }, 'Yes'.tr, 'Cancel'.tr);
                                                },
                                              )
                                            : PdfCard(
                                                onDeleteTap: () {
                                                  UiUtilites.confirmAlert(
                                                      context,
                                                      'Are you sure you want to delete this File?'
                                                          .tr, () {
                                                    controller.deleteFile(
                                                        controller
                                                            .planfiles[index]);
                                                  }, () {
                                                    Get.back();
                                                  }, 'Yes'.tr, 'Cancel'.tr);
                                                },
                                                onPressed: () {
                                                  String remotePDFpath;
                                                  controller
                                                      .createFileOfPdfUrl(
                                                          controller
                                                              .planfiles[index]
                                                              .fileUrl)
                                                      .then((f) {
                                                    setState(() {
                                                      remotePDFpath = f.path;

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PDFScreen(
                                                                  path:
                                                                      remotePDFpath),
                                                        ),
                                                      );
                                                    });
                                                  });
                                                },
                                                title: controller
                                                    .planfiles[index].fileName,
                                                description: '',
                                              );
                                      }),
                                ),
                                const SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: IconButtons(
                            onPressed: () {
                              controller.sendPlan();
                            },
                            title: 'Send Plan'.tr,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}
