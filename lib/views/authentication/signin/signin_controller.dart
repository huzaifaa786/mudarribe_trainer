
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController instance = Get.find();



bool obscureTextPassword = true;

  void toggle() {
    obscureTextPassword = !obscureTextPassword;
    update();
  }
}