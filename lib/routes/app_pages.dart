import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/views/Tprofile/addpost.dart';
import 'package:mudarribe_trainer/views/Tprofile/profile_binding.dart';
import 'package:mudarribe_trainer/views/changepassword/changepassword_view.dart';
import 'package:mudarribe_trainer/views/changepassword/forgetpassword.dart';
import 'package:mudarribe_trainer/views/plans/addplans/addplan_binding.dart';
import 'package:mudarribe_trainer/views/plans/editplan/editplan_binding.dart';
import 'package:mudarribe_trainer/views/plans/editplan/editplan_view.dart';
import 'package:mudarribe_trainer/views/editprofile/editprofile_view.dart';
import 'package:mudarribe_trainer/views/event/add_event/add_event.dart';
import 'package:mudarribe_trainer/views/Tprofile/Tprofile_view.dart';
import 'package:mudarribe_trainer/views/authentication/signin/signin_view.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_view.dart';

import 'package:mudarribe_trainer/views/chats/allChats/allchats_view.dart';

import 'package:mudarribe_trainer/views/event/myevent_view.dart';
import 'package:mudarribe_trainer/views/home/home_view.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_binding.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_view.dart';
import 'package:mudarribe_trainer/views/order/order_view.dart';
import 'package:mudarribe_trainer/views/plans/exersize/exersize.dart';
import 'package:mudarribe_trainer/views/packges/packages_view.dart';
import 'package:mudarribe_trainer/views/plans/addplans/addplan_view.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_view.dart';
import 'package:mudarribe_trainer/views/plans/send_plan/today_meals.dart';
import 'package:mudarribe_trainer/views/promocode/promoCode_view.dart';
import 'package:mudarribe_trainer/views/sale/sale_view.dart';

// import 'package:mudarribe_trainer/views/plans/sendplan/home_view.dart';
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
        binding: IntroBinding()),
    GetPage(
      name: AppRoutes.sale,
      page: () => const SaleScreen(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrderScreen(),
    ),
    GetPage(
      name: AppRoutes.chats,
      page: () => const Chats(),
    ),
    GetPage(
      name: AppRoutes.changepassword,
      page: () => const ChangePassword(),
    ),
    GetPage(
      name: AppRoutes.editplan,
      page: () => const EditPlanView(),
      binding: EditPlanBinding()
    ),
    GetPage(
      name: AppRoutes.editprofile,
      page: () => const EditProfile(),
    ),
    GetPage(
      name: AppRoutes.promoCode,
      page: () => const PromoCode(),
      // binding: 
    ),
    GetPage(
      name: AppRoutes.personalplan,
      page: () => const PersonalPlan(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.packagesScreen,
      page: () => const PackagesScreen(),
    ),
    GetPage(
      name: AppRoutes.todaymeals,
      page: () => const TodayMealsScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.planhome,
    //   page: () => const HomePlan(),
    // ),
    GetPage(
      name: AppRoutes.profile,
      binding: ProfileBinding(),
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.addplan,
      page: () => const AddPlan(),
      binding: AddPlanBinding(),
    ),
    GetPage(
      name: AppRoutes.myevent,
      page: () => const MyEvent(),
    ),
    GetPage(
      name: AppRoutes.exersize,
      page: () => const ExersizeScreen(),
    ),
    GetPage(
      name: AppRoutes.addevent,
      page: () => const AddEventScreen(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: AppRoutes.addpost,
      page: () => const AddPost(),
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => const ForgetPassword(),
    ),
  ];
}
