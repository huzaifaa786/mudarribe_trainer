import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/components/meals_card.dart';
import 'package:mudarribe_trainer/components/pdfcard.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/sendplan/existing_plan/existing_plan_controller.dart';

class TodayMealsScreen extends StatefulWidget {
  const TodayMealsScreen({super.key});

  @override
  State<TodayMealsScreen> createState() => _TodayMealsScreenState();
}

class _TodayMealsScreenState extends State<TodayMealsScreen> {
  String title = '02';
  String description = 'Full Body Energy';
  String imgpath1 = 'assets/images/containimg.jpeg';

  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as String;
    print(category);

    return GetBuilder<ExistingPlanController>(
      initState: (state) async {
        Future.delayed(const Duration(milliseconds: 100), () {
          state.controller!.planId = category;
          state.controller!.getTrainerFiles();
        });
      },
      builder: (controller) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            const TopBar(
              text: 'Today Meals',
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.only(right: 15, left: 15, top: 45),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      IconButtons(title: 'Upload New Files', onPressed: () {}),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.builder(
                            itemCount: controller.planfiles.length,
                            itemBuilder: (context, index) {
                              return controller.planfiles[index].fileType ==
                                      FileType.mp4
                                  ? MealsCard(
                                      onPressed: () {},
                                      title: controller
                                          .planfiles[index].fileName
                                          .toString(),
                                      description: 'f',
                                      imgpath1: imgpath1,
                                    )
                                  : PdfCard(
                                     title: controller
                                          .planfiles[index].fileName,
                                      description: 'f',
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
                  onPressed: () {},
                  title: 'Send Plan',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
