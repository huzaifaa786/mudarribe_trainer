import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/packges/package_controller.dart';

class PackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackageController());
  }
}
