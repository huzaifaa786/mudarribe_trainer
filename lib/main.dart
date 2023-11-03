import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/signin.dart/view.dart';


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
      initialRoute: 'signup', 
      routes: {
        'signup': (_) => Signup(),
        // 'splash': (_) => SplashScreen(),
        // 'login': (_) => LoginScreen(),
        // // 'VerifyPhone': (_) => VerifyPhone(),
        // 'NoTranslator': (_) => NoTransFound_screen(),
        // 'Verify': (_) => EmailOtpVerifyScreen(),
      },
    );
  }
}
