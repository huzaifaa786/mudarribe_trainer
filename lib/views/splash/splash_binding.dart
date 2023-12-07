import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/views/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BusyController>(BusyController());
    Get.lazyPut(() => SplashController());

  }
}
