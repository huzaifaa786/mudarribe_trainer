// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/services/package_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class AddPlanController extends GetxController {
  static AddPlanController instance = Get.find();
  final BusyController busyController = Get.find();
  TextEditingController packagenameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  // TextEditingController durationController = TextEditingController();
    TextEditingController searchController = TextEditingController();
  String? fromSelectedduration;

  TextEditingController discriptionController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  final _packageService = PackageService();

  final _authApi = AuthApi();
  AppUser? currentUser;
  final _userService = UserService();

  String category = '';

  onnutritiontap() {
    category = 'nutrition';
    checkFields();
    update();
    return category;
  }

  onexcercisetap() {
    category = 'excercise';
    checkFields();
    update();
    return category;
  }

  onbothtap() {
    category = 'excercise&nutrition';
    checkFields();
    update();
    return category;
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();

      update();
    }
  }

  @override
  void onInit() {
    getAppUser();
    packagenameController.addListener(() {
      checkFields();
    });
    priceController.addListener(() {
      checkFields();
    });
    discriptionController.addListener(() {
      checkFields();
    });

    super.onInit();
  }

  void checkFields() {
    if (packagenameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        fromSelectedduration!.isNotEmpty &&
        discriptionController.text.isNotEmpty &&
        category != '') {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future addpackage() async {
    busyController.setBusy(true);
    final packageId = DateTime.now().millisecondsSinceEpoch.toString();

    await _packageService.createPackage(
        package: Package(
            id: packageId,
            trainerId: currentUser!.id,
            name: packagenameController.text,
            price: priceController.text,
            duration: fromSelectedduration,
            discription: discriptionController.text,
            category: category));

    packagenameController.clear();
    priceController.clear();
    fromSelectedduration = null;
    discriptionController.clear();
    category = '';
    areFieldsFilled.value = false;
    busyController.setBusy(false);
    Get.back();
    UiUtilites.successAlert(Get.context, 'Package Added\nSuccessfully !'.tr);
  }
}
