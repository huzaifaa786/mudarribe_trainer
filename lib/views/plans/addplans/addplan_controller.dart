// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/package_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class AddPlanController extends GetxController {
  static AddPlanController instance = Get.find();
  TextEditingController packagenameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  final _packageService = PackageService();

  final _authApi = AuthApi();
  AppUser? currentUser;
  final _userService = UserService();

  String category = '';

  onnutritiontap() {
    category = 'nutrition';
    update();
    return category;
  }

  onexcercisetap() {
    category = 'excercise';
    update();
    return category;
  }

  onbothtap() {
    category = 'excercise&nutrition';
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
    durationController.addListener(() {
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
        durationController.text.isNotEmpty &&
        discriptionController.text.isNotEmpty &&
        category != '') {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future<void> addpackage(context) async {
    final packageId = DateTime.now().millisecondsSinceEpoch.toString();

    await _packageService.createPackage(
        package: Package(
            id: packageId,
            trainerid: currentUser!.id,
            name: packagenameController.text,
            price: priceController.text,
            duration: durationController.text,
            discription: discriptionController.text,
            category: category));
    UiUtilites.successAlert(context, 'Package Added\nSuccessfully !');

    packagenameController.clear();
    priceController.clear();
    durationController.clear();
    discriptionController.clear();
    category='';
    areFieldsFilled = true.obs;
    

    Get.toNamed(AppRoutes.packagesScreen);
  }
}
