// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/values/controller.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    splashController.initscreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //       Color(4289491966),
        //       Color(4289491966),
        //       Color(4289494015),
        //       Color(4289494015),
        //       Color(4289494015),
        //       Color(4289505535),
        //       Color(4288538110),
        //       Color(4292214271)
        //     ],
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashtrainer.png'),
            //  SizedBox(height: 14),
            //  Text(
            //   "Find Your Personal Trainer".tr,
            //   style: TextStyle(
            //     fontFamily: "Poppins",
            //     fontSize: 13,
            //     fontWeight: FontWeight.w400,
            //     color: Colors.white,
            //     height: 5 / 12,
            //   ),
            // ),
            // const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
