import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/views/Tprofile/profile_binding.dart';
import 'package:mudarribe_trainer/views/changepassword/changepassword_view.dart';
import 'package:mudarribe_trainer/views/changepassword/forgetpassword.dart';
import 'package:mudarribe_trainer/views/event/add_event/add_event_binding.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_binding.dart';
import 'package:mudarribe_trainer/views/plans/addplans/addplan_binding.dart';
import 'package:mudarribe_trainer/views/plans/editplan/editplan_binding.dart';
import 'package:mudarribe_trainer/views/plans/editplan/editplan_view.dart';
import 'package:mudarribe_trainer/views/editprofile/editprofile_view.dart';
import 'package:mudarribe_trainer/views/event/add_event/add_event_view.dart';
import 'package:mudarribe_trainer/views/Tprofile/addpost_binding.dart';
import 'package:mudarribe_trainer/views/Tprofile/addpost_view.dart';
import 'package:mudarribe_trainer/views/authentication/signin/signin_binding.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_binding.dart';
import 'package:mudarribe_trainer/views/changepassword/changepassword_binding.dart';
import 'package:mudarribe_trainer/views/changepassword/forget_password_binding.dart';
import 'package:mudarribe_trainer/views/editprofile/editprofile_binding.dart';
import 'package:mudarribe_trainer/views/home/home_binding.dart';
import 'package:mudarribe_trainer/views/Tprofile/profile_view.dart';
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
import 'package:mudarribe_trainer/views/promocode/promoCode_binding.dart';
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
      binding: SignUpBinding()
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
        binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.forgetpassword,
      page: () => const ForgetPassword(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.editplan,
      page: () => const EditPlanView(),
      binding: EditPlanBinding()
    ),
    GetPage(
        name: AppRoutes.editprofile,
        page: () => const EditProfile(),
        binding: EditProfileBinding()),
    GetPage(
      name: AppRoutes.promoCode,
      page: () => const PromoCode(),
      // binding: 
    ),
    GetPage(
      name: AppRoutes.personalplan,
      page: () => const PersonalPlan(),
         binding: PersonalPlanBinding(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      // middlewares: [AuthGuard()]
    ),
    GetPage(
      name: AppRoutes.packagesScreen,
      page: () => const PackagesScreen(),
    ),
    GetPage(
      name: AppRoutes.todaymeals,
      page: () => const TodayMealsScreen(),
    ),
      GetPage(
      name: AppRoutes.promocode,
      page: () => const PromoCode(),
      binding: PromoCodeBinding()
    ),
   
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding()
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
      binding: AddEventBinding()
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => const SignInScreen(),
      binding: SignInBinding()
    ),
    GetPage(
      name: AppRoutes.addpost,
      page: () => const AddPost(),
      binding: AddPostBinding()
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => const ForgetPassword(),
    ),
  ];
}
