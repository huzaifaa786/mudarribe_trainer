import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/plans/editplan/editplan_controller.dart';

class EditPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPlanController());
  }
}
