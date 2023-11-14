import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/introscreen/intro_controller.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroController());
  }
}
