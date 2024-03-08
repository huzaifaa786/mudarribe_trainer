import 'package:get/get.dart';

class IntroController extends GetxController {
  static IntroController instance = Get.find();
  String selected = '';
  onExistingtap() {
    selected = 'Existing';
    update();
  }
  onNewtap() {
    selected = 'New';
    update();
  }

   onclick() {
    selected = 'click';
    update();
  }

}
