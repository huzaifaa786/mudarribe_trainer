import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_controller.dart';


class SignUpBinding extends Bindings {
  @override
  void dependencies() {
          Get.put<BusyController>(BusyController());
    Get.lazyPut(() => SignUpController());
  }
}
