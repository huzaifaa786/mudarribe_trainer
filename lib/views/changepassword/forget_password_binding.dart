
import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/changepassword/forget_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordContoller());
  }
}