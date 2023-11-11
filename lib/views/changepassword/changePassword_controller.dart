import 'package:get/get.dart';

class ChangepasswordController extends GetxController {
  static ChangepasswordController instance = Get.find();

  String selected = '';
  bool obscureTextOldPassword = true;
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

  void toggle2() {
    obscureTextOldPassword = !obscureTextOldPassword;
    update();
  }
}
