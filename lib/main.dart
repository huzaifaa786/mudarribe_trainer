import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mudarribe_trainer/views/splash/splash_binding.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mudarribe_trainer/views/splash/splash_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mudarribe_trainer/views/chat/controller.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await LoadingHelper.init();

  await GetStorage.init();
  Get.put<BusyController>(BusyController());
  Stripe.publishableKey =
      "pk_test_51JvIZ1Ey3DjpASZjPAzcOwqhblOq2hbchp6i56BsjapvhWcooQXqh33XwCrKiULfAe7NKFwKUhn2nqURE7VZcXXf00wMDzp4YN";
      
  // Stripe.merchantIdentifier = 'merchant.com.ezmove';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
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
        ),
        debugShowCheckedModeBanner: false,
        title: "Mudarribe",
        initialBinding: SplashBinding(),
        home: const SplashView(),
        getPages: AppPages.pages,
      ),
    );
  }
}
