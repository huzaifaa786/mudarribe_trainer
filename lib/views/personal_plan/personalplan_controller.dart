import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/personal_plan.dart';
import 'package:mudarribe_trainer/services/personal_plan.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class PersonalPlanController extends GetxController {
  static PersonalPlanController instance = Get.find();

  TextEditingController plantitleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  RxBool areFieldsFilled = false.obs;
  final _personalplanService = PersonalPlanService();

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
    plantitleController.addListener(() {
      checkFields();
    });
    priceController.addListener(() {
      checkFields();
    });

    super.onInit();
  }

  void checkFields() {
    if (plantitleController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        category != '') {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  String? content;
  Future addplan() async {
    final packageId = DateTime.now().millisecondsSinceEpoch.toString();
    content = 'PlanTitle:' +
        plantitleController.text +
        '~~AMOUNT:' +
        priceController.text +
        '~~PlanCategory:' +
        category +
        '~~pay:' +
        'false' +
        '~~PlanId:' +
        packageId;
    update();
    await _personalplanService.createpersonalPlan(
        personalPlan: PersonalPlan(
            id: packageId,
            trainerId: currentUser!.id,
            name: plantitleController.text,
            price: priceController.text,
            category: category));

    plantitleController.clear();
    priceController.clear();

    category = '';
    areFieldsFilled.value = false;

    // Get.back();
    // UiUtilites.successAlert(Get.context, 'Package Added\nSuccessfully !');
  }
}
