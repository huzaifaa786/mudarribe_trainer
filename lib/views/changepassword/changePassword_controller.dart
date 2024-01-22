import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class ChangepasswordController extends GetxController {
  static ChangepasswordController instance = Get.find();
  final BusyController busyController = Get.find();

  String selected = '';
  bool obscureTextOldPassword = true;
  bool obscureTextPassword = true;
  bool obscureTextCPassword = true;
  RxBool areFieldsFilled = false.obs;
  final _authApi = AuthApi();

  TextEditingController newpassword = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  void toggle() {
    obscureTextPassword = !obscureTextPassword;
    update();
  }

  void toggle1() {
    obscureTextCPassword = !obscureTextCPassword;
    update();
  }

  void toggle2() {
    obscureTextOldPassword = !obscureTextOldPassword;
    update();
  }

  @override
  void onInit() {
    newpassword.addListener(() {
      checkFields();
    });
    oldpassword.addListener(() {
      checkFields();
    });
    confirmPassword.addListener(() {
      checkFields();
    });
    super.onInit();
  }

  void checkFields() {
    if (newpassword.text.isNotEmpty &&
        oldpassword.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty) {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future changePassword() async {
    busyController.setBusy(true);
    if (newpassword.text != confirmPassword.text) {
      UiUtilites.successSnackbar('Password are not similar'.tr, 'Password'.tr);
    } else {
      final response =
          await _authApi.verifyOldPassword(oldpassword.text, newpassword.text);

      if (response == 0) {
      } else if (response == 2) {
        UiUtilites.errorSnackbar('Provide correct old password'.tr, 'Password'.tr);
      } else if (response == 3) {
        oldpassword.clear();
        newpassword.clear();
        confirmPassword.clear();

        UiUtilites.successSnackbar('Password has been updated'.tr, 'Password'.tr);
      }
    }
    busyController.setBusy(false);
  }
}
