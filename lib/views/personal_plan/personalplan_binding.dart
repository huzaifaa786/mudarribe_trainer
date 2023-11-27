import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/personal_plan/personalplan_controller.dart';

class PersonalPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalPlanController());
  }
}