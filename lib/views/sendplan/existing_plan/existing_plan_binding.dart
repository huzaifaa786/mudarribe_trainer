
import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/sendplan/existing_plan/existing_plan_controller.dart';


class ExistingPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExistingPlanController());
  }
}