import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:mudarribe_trainer/views/changepassword/changePassword_controller.dart';
import 'package:mudarribe_trainer/views/changepassword/forgetpassword.dart';

import 'package:mudarribe_trainer/views/authentication/signin/signin_controller.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_controller.dart';

import 'package:mudarribe_trainer/views/introscreen/intro_controller.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_controller.dart';

import 'package:mudarribe_trainer/views/sale/sale_controller.dart';

import 'package:mudarribe_trainer/views/splash/splash_controller.dart';
import 'firebase_options.dart';
import 'package:mudarribe_trainer/views/splash/splash_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(IntroController());
  Get.put(SplashController());
  Get.put(ChangepasswordController());
  Get.put(PersonalPlanController());

  Get.put(SignUpController());
  Get.put(SignInController());
  Get.put(ChangepasswordController());
  Get.put(PersonalPlanController());
  Get.put(SaleController());

  // await LoadingHelper.init();

  await GetStorage.init();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: "Mudarribe",
      initialBinding: SplashBinding(),
      home: const ForgetPassword(),
      getPages: AppPages.pages,
    );
  }
}
