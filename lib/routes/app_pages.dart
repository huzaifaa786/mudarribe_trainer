import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_view.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_view.dart';
import 'package:mudarribe_trainer/views/order/order_view.dart';
import 'package:mudarribe_trainer/views/plans/exersize/exersize.dart';
import 'package:mudarribe_trainer/views/sale/sale_view.dart';
import 'package:mudarribe_trainer/views/splash/splash_binding.dart';
import 'package:mudarribe_trainer/views/splash/splash_view.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: AppRoutes.sale,
      page: () => const SaleScreen(),
    ),
     GetPage(
      name: AppRoutes.orders,
      page: () => const OrderScreen(),
    ),
      GetPage(
      name: AppRoutes.todaymeals,
      page: () => const OrderScreen(),
    ),
      GetPage(
      name: AppRoutes.exersize,
      page: () => const ExersizeScreen(),
    ),
  ];
}