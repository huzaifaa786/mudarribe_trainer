import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/services/user_service.dart';

class AddEventContoller extends GetxController {
  static AddEventContoller instance = Get.find();
  int selectedOption = 1;
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  void value(value) {
    selectedOption = value!;
    update();
  }
}
