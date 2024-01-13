import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/userSelectionCard.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_controller.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23, top: 70),
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 70,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Choose to continue',
                    style: TextStyle(color: Colors.white),
                  ).translate(),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SelectUserCard(
                text: 'New Trainer',
                selected: introController.selected == 'New' ? true : false,
                ontap: introController.onNewtap,
              ),
               Padding(
                padding: EdgeInsets.only(top: 12, bottom: 14),
                child: Text(
                  'OR',
                  style: TextStyle(color: Colors.white),
                ).translate(),
              ),
              SelectUserCard(
                text: 'Existing Trainer',
                selected: introController.selected == 'Existing' ? true : false,
                ontap: introController.onExistingtap,
              ),
              const SizedBox(
                height: 80,
              ),
              GradientButton(
                title: 'Next',
                onPressed: () {
                  if (introController.selected == 'New') {
                    Get.toNamed(AppRoutes.signup);
                  } else if (introController.selected == 'Existing') {
                    Get.toNamed(AppRoutes.signin);
                  }
                },
                selected: introController.selected == '' ? false : true,
              )
            ],
          ),
        )),
      ),
    );
  }
}
