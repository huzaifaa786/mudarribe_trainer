import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/changepassword/changePassword_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangepasswordController());
  }
}