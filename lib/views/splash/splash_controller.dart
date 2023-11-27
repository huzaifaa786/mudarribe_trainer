import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/user_service.dart';

class SplashController extends GetxController {
  static SplashController instance = Get.find();
  final _userService = UserService();
  void initscreen() async {
    await Future.delayed(const Duration(seconds: 3), () {
      checkFirstSeen();
    });
  }

  Future checkFirstSeen() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      AppUser? appUser = await _userService.getAuthUser();

      if (appUser != null && appUser.status == TrainerStatus.approved) {
        Get.offAllNamed(AppRoutes.HomeScreen);
      } else {
        Get.offAllNamed(AppRoutes.intro);
      }
    } else {
      Get.offAllNamed(AppRoutes.intro);
    }
  }
}
