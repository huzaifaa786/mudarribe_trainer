import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:mudarribe_trainer/views/splash/splash_view.dart';
import 'firebase_options.dart';
import 'package:mudarribe_trainer/views/splash/splash_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // await LoadingHelper.init();

  await GetStorage.init();

  runApp(
    const MyApp(),
  );
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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      title: "Mudarribe",
      initialBinding: SplashBinding(),
      home: const SplashView(),
      getPages: AppPages.pages,
    );
  }
}
