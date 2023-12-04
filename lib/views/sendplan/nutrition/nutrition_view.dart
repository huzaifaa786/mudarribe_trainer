import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/exersize_card.dart';
import 'package:mudarribe_trainer/components/icon_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/sendplan/nutrition/nutrition_controller.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final String title = 'Mornning Workouts';
  final String description = '3 Files ,6 videos';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionController>(
      builder: (controller) =>  Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            const TopBar(text: 'Nutrition'),
            Flexible(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.only(right: 15, left: 15, top: 15,),
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
                            const Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Text("New Plan File",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            const InputField(
                              lable: 'File Name',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25, bottom: 25),
                              child: IconButtons(
                                  title: 'Upload Plan Files', onPressed: () {}),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 20),
                        child: Image.asset('assets/images/ortext.png'),
                      ),
                      const Text("Add to Existing File",
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      ExersizeCard(title: title, description: description),
                      ExersizeCard(title: title, description: description),
                      Padding(
                        padding:  const EdgeInsets.only(top: 20,bottom: 20),
                        child: GradientButton(title: 'Next', onPressed: (){}),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}