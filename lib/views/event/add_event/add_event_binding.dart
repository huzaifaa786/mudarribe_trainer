import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/event/add_event/add_event_controller.dart';

class AddEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEventContoller());
  }
}
