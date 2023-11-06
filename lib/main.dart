import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/chats/chats.dart';
import 'package:mudarribe_trainer/views/editprofile/edit_profile.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_controller.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_view.dart';
import 'package:mudarribe_trainer/views/signin.dart/signin_controller.dart';
import 'package:mudarribe_trainer/views/signin.dart/view.dart';
import 'package:mudarribe_trainer/views/splash/splash_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(IntroController());
  Get.put(SplashController());
  Get.put(SigninController());
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
      navigatorKey: navigatorKey,
      // theme: Styles.lightTheme,
      // builder: EasyLoading.init(),
      title: "translation",
      initialRoute: 'edit',
      routes: {
        'signup': (_) => Signup(),
        'intro': (_) => IntroScreen(),
        'edit': (_) => EditProfile(),
        'chats': (_) => Chats(),

        // 'login': (_) => LoginScreen(),
        // // 'VerifyPhone': (_) => VerifyPhone(),
        // 'NoTranslator': (_) => NoTransFound_screen(),
        // 'Verify': (_) => EmailOtpVerifyScreen(),
      },
    );
  }
}
