import 'dart:io';

import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/file_selector_api.dart';

class SendPlanController extends GetxController {
  static SendPlanController instance = Get.find();

  RxBool areFieldsFilled = false.obs;
  final _fileSelectorApi = FileSelectorApi();
  String category = '';
  File? file;

  onnutritiontap() {
    category = 'nutrition';
    update();
    checkFields();
  }

  onexcercisetap() {
    category =
        'excercise'; // Corrected the typo here ('excercise' to 'exercise')
    update();
    checkFields();
  }



  void checkFields() {
    if (category != '') {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }
}
