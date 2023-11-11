import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_view.dart';
import 'package:mudarribe_trainer/views/changepassword/changepassword_view.dart';
import 'package:mudarribe_trainer/views/chats/allChats/allchats_view.dart';
import 'package:mudarribe_trainer/views/editplan/editplan-view.dart';
import 'package:mudarribe_trainer/views/editprofile/editprofile_view.dart';
import 'package:mudarribe_trainer/views/home/home_view.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_view.dart';
import 'package:mudarribe_trainer/views/order/order_view.dart';
import 'package:mudarribe_trainer/views/packges/packages_view.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_view.dart';
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
      name: AppRoutes.orders,
      page: () => const Chats(),
    ),
      GetPage(
      name: AppRoutes.orders,
      page: () => const ChangePassword(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const EditPlans(),
    ),
     GetPage(
      name: AppRoutes.orders,
      page: () => const EditProfile(),
    ),
     GetPage(
      name: AppRoutes.orders,
      page: () => const PersonalPlan(),
    ),
     GetPage(
      name: AppRoutes.orders,
      page: () => const HomeScreen(),
    ),
     GetPage(
      name: AppRoutes.orders,
      page: () => const PackagesScreen(),
     ),
      GetPage(
      name: AppRoutes.todaymeals,
      page: () => const OrderScreen(),
    ),
  ];
}