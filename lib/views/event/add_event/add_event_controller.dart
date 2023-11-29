import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
