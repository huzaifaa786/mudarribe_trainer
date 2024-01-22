// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/database_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/exceptions/auth_api_exception.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class SignInController extends GetxController {
  static SignInController instance = Get.find();
  final BusyController busyController = Get.find();
  final _authApi = AuthApi();
  final _userService = UserService();
  final _databaseApi = DatabaseApi();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  bool obscureTextPassword = true;

  void toggle() {
    obscureTextPassword = !obscureTextPassword;
    update();
  }

  // Check all inputs are filled or not
  void checkFields() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      areFieldsFilled.value = true;
    } else {
      areFieldsFilled.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      checkFields();
    });
    passwordController.addListener(() {
      checkFields();
    });
  }

  Future signInTrainer() async {
    busyController.setBusy(true);

    try {
      final User user = await _authApi.loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
      );

      if (user.uid.isNotEmpty) {
        AppUser? appUser = await _userService.getAuthUser();

        if (appUser != null && appUser.status == TrainerStatus.approved) {
          obscureTextPassword = true;
          var token = await FirebaseMessaging.instance.getToken();
          await updateUser(id: user.uid, user: {"firebaseToken": token});
          Get.offNamed(AppRoutes.homeScreen);
        } else {
          UiUtilites.errorSnackbar(
              'Pending Approval'.tr, 'Trainer not approved yet from admin'.tr);
        }
      }
    } on AuthApiException catch (e) {
      UiUtilites.errorSnackbar('Signin Failed'.tr, e.toString());
    }
    busyController.setBusy(false);
  }

  Future<void> updateUser({
    required id,
    required user,
  }) async {
    await _databaseApi.updateUser(id, user);
  }
}
