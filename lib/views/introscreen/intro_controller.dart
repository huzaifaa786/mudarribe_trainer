import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_view.dart';

class IntroController extends GetxController {
  static IntroController instance = Get.find();
  String selected = '';
  onExistingtap() {
    print(selected);
    selected = 'Existing';
    update();
  }
  onNewtap() {
    selected = 'New';
    print(selected);
    update();
  }

   onclick() {
    selected = 'click';
    print(selected);
    update();
  }

}
