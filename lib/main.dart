import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/existing/send_plan/today_meals.dart';
import 'package:mudarribe_trainer/views/mainScreen/mainScreen.dart';
import 'package:mudarribe_trainer/views/packges/packages/packages.dart';
import 'package:mudarribe_trainer/views/signin.dart/view.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // theme: Styles.lightTheme,
      // builder: EasyLoading.init(),
      title: "translation",
      initialRoute: 'todaymeals',
      routes: {
        'signup': (_) => Signup(),
        'mainscreen': (_) => MainScreen(),
        'packages': (_) => PackagesScreen(),
        'todaymeals': (_) => TodayMealsScreen(),
        // 'splash': (_) => SplashScreen(),
        // 'login': (_) => LoginScreen(),
        // // 'VerifyPhone': (_) => VerifyPhone(),
        // 'NoTranslator': (_) => NoTransFound_screen(),
        // 'Verify': (_) => EmailOtpVerifyScreen(),
      },
    );
  }
}
