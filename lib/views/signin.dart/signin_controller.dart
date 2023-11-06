import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_view.dart';

class SigninController extends GetxController {
  static SigninController instance = Get.find();
  String selected = '';
  onfemaletap() {
    selected = 'female';
    update();
  }

  onmaletap() {
    selected = 'male';
    print(selected);
    update();
  }

  onclick() {
    selected = 'click';
    print(selected);
    update();
  }

  bool obscureTextPassword = true;
  bool obscureTextCPassword = true;
  void toggle() {
    obscureTextPassword = !obscureTextPassword;
    update();
  }

  void toggle1() {
    obscureTextCPassword = !obscureTextCPassword;
    update();
  }
}
