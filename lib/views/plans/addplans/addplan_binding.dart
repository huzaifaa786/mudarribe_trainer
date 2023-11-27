import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/plans/addplans/addplan_controller.dart';

class AddPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPlanController());
  }
}
