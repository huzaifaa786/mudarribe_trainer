import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/exersize_card.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/sendplan/exercises/exercises_controller.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final String title = 'Mornning Workouts';
  final String description = '3 Files ,6 videos';
  @override
  Widget build(BuildContext context) {
    var category = Get.parameters['category'] as String;
    var userId = Get.parameters['userId'] as String;
    var orderId = Get.parameters['orderId'] as String;
    var firebaseToken = Get.parameters['firebaseToken'] as String;
    var trainerName = Get.parameters['trainerName'] as String;

    return GetBuilder<ExercisesController>(
      initState: (state) async {
        Future.delayed(const Duration(milliseconds: 100), () {
          state.controller!.category = category;
          state.controller!.orderId = orderId;
          state.controller!.userId = userId;
          state.controller!.firebaseToken = firebaseToken;
          state.controller!.trainerName = trainerName;
        });
      },
      builder: (controller) => BusyIndicator(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                text: category.capitalize,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: const EdgeInsets.only(
                    right: 15,
                    left: 15,
                    top: 15,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: const Color(0x872C2723),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 25),
                                child: Text("New Plan File",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    )) ,
                              ),
                              InputField(
                                controller: controller.filenameController,
                                lable: 'File Name',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 25),
                                child: IconButtons(
                                    title: 'Upload Plan Files',
                                    onPressed: () {
                                      controller.selectmultipleFiles();
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 20),
                          child: Image.asset('assets/images/ortext.png'),
                        ),
                        Text("Add to Existing File",
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )) ,
                        controller.plans.isNotEmpty
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.plans.length,
                                itemBuilder: (context, index) => ExersizeCard(
                                  radiovalue: controller.plans[index].id,
                                  groupValue: controller.selectedPlan,
                                  onChanged: (value) {
                                    controller.changePlan(value);
                                  },
                                  title: controller.plans[index].name,
                                  description:
                                      controller.plans[index].description,
                                ),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Text(
                                    'There are no Existing files! Create new one .',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white
                                          .withOpacity(0.6000000238418579),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ) ,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientButton(
              title: 'Next ',
              onPressed: controller.areFieldsFilled.value
                  ? () {
                      Get.offNamed(AppRoutes.existingsendplan, parameters: {
                        "planId": controller.selectedPlan,
                        "userId": controller.userId,
                        "orderId": controller.orderId,
                        'firebaseToken': controller.firebaseToken,
                        'category': controller.category,
                        'trainerName': controller.trainerName
                      });
                    }
                  : () {
                      UiUtilites.errorSnackbar('Fill out all fields',
                          'Please fill all above fields');
                    },
              selected: controller.areFieldsFilled.value,
            ),
          ),
        ),
      ),
    );
  }
}
