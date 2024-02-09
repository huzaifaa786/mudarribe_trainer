import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/app_user_trans.dart';
import 'package:mudarribe_trainer/services/user_service.dart';

class HomeContoller extends GetxController {
  static HomeContoller instance = Get.find();
  final BusyController busyController = Get.find();
  final _userService = UserService();
  AppUserTransalted? currentUser;

  @override
  void onInit() {
    getAppUser();
    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser1();
    }
    update();
  }

//   userlogout() {
// logout();

//   }
}
