
import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/sendplan/sendplan_controller.dart';

class SendPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendPlanController());
  }
}