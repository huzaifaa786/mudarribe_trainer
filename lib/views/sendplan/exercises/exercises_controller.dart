import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/file_selector_api.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/plan.dart';
import 'package:mudarribe_trainer/services/plan_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class ExercisesController extends GetxController {
  static ExercisesController instance = Get.find();

  TextEditingController filenameController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  final _fileSelectorApi = FileSelectorApi();
  String category = '';
  File? file;
  final _authApi = AuthApi();
  AppUser? currentUser;
  final _userService = UserService();
  final _planService = PlanService();

  void checkFields() {
    if (filenameController.text.isNotEmpty && file != []) {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();

      update();
    }
  }

  Future selectFilee() async {
    final tempFile = await _fileSelectorApi.selectFile();
    file = tempFile;
    checkFields();
    update();
  }

  void onInit() {
    getAppUser();

    super.onInit();
  }

  Future addplan() async {
    final planId = DateTime.now().millisecondsSinceEpoch.toString();

    await _planService.createPlan(
        plan: Plan(
            id: planId,
            trainerId: currentUser!.id,
            name: filenameController.text,
            category: category));
    print('object+++++++++++++++++++++');

    filenameController.clear();

    category = '';
    areFieldsFilled.value = false;
    storepalnfiles(planId);

    Get.back();
    UiUtilites.successAlert(Get.context, 'Package Added\nSuccessfully !');
  }

  Future storepalnfiles(planId) async {
    final fileId = DateTime.now().millisecondsSinceEpoch.toString();




    
  }
}
