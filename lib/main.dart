import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'package:mudarribe_trainer/views/chat/controller.dart';
import 'package:mudarribe_trainer/views/splash/splash_view.dart';
import 'firebase_options.dart';
import 'package:mudarribe_trainer/views/splash/splash_binding.dart';
import 'package:provider/provider.dart';
=======
import 'package:mudarribe_trainer/views/sendplan/home_view.dart';
import 'package:mudarribe_trainer/views/splash/splash_binding.dart';
import 'package:mudarribe_trainer/views/splash/splash_view.dart';

import 'firebase_options.dart';
>>>>>>> 0688dbde01d291a90d2b0349a1ad31eda38b15b5

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await LoadingHelper.init();

  await GetStorage.init();
  Get.put<BusyController>(BusyController());
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
<<<<<<< HEAD
    return MultiProvider(
      providers: [
        Provider<ChatProvider>(
          create: (_) => ChatProvider(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          scaffoldBackgroundColor: Colors.black,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.white,
          ),
          useMaterial3: true,
          fontFamily: 'Montserrat',
=======
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
>>>>>>> 0688dbde01d291a90d2b0349a1ad31eda38b15b5
        ),
        debugShowCheckedModeBanner: false,
        title: "Mudarribe",
        initialBinding: SplashBinding(),
        home: const SplashView(),
        getPages: AppPages.pages,
      ),
<<<<<<< HEAD
=======
      debugShowCheckedModeBanner: false,
      title: "Mudarribe",
      initialBinding:SplashBinding (),
      home: const SplashView(),
      getPages: AppPages.pages,
>>>>>>> 0688dbde01d291a90d2b0349a1ad31eda38b15b5
    );
  }
}
