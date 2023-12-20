// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';

import 'package:mudarribe_trainer/services/user_service.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  final BusyController busyController = Get.find();

  String? id;

  RxBool areFieldsFilled = false.obs;
  final _authApi = AuthApi();
  
  AppUser? currentUser;
  final _userService = UserService();

  @override
  void onInit() {
    getAppUser();

    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
      update();
    }
  }
}
