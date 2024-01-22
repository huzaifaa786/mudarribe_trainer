// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/promocode.dart';
import 'package:mudarribe_trainer/services/promocode_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class PromoCodeContoller extends GetxController {
  static PromoCodeContoller instance = Get.find();
  final BusyController busyController = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController percentagecontroller = TextEditingController();
  String? id;
  final _promocodeService = PromoCodeService();
  RxBool areFieldsFilled = false.obs;
  final _authApi = AuthApi();
  AppUser? currentUser;
  final _userService = UserService();
  bool edit = false;

  @override
  void onInit() {
    getAppUser();
    nameController.addListener(() {
      checkFields();
    });
    percentagecontroller.addListener(() {
      checkFields();
    });

    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
      update();
    }
  }

  void checkFields() {
    if (nameController.text.isNotEmpty &&
        percentagecontroller.text.isNotEmpty) {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future storePromocode() async {
    busyController.setBusy(true);
    final promoId = DateTime.now().millisecondsSinceEpoch.toString();

    await _promocodeService.createpromocode(
        promocode: PromoCode(
      id: promoId,
      trainerId: currentUser!.id,
      name: nameController.text,
      discount: percentagecontroller.text,
    ));

    nameController.clear();
    percentagecontroller.clear();

    areFieldsFilled.value = false;
    busyController.setBusy(false);
    Get.back();
    UiUtilites.successAlert(Get.context, 'Promo Code Added\nSuccessfully!'.tr);
  }

    Future updatePromocode() async {
    busyController.setBusy(true);
    // final promoId = DateTime.now().millisecondsSinceEpoch.toString();

    await _promocodeService.createpromocode(
        promocode: PromoCode(
      id: id.toString(),
      trainerId: currentUser!.id,
      name: nameController.text,
      discount: percentagecontroller.text,
    ));

    nameController.clear();
    percentagecontroller.clear();

    areFieldsFilled.value = false;
    busyController.setBusy(false);
    Get.back();
    UiUtilites.successAlert(Get.context, 'Promo Code Added\nSuccessfully!'.tr);
  }
}
