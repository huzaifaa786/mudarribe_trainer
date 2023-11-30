import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/event/myevent_controller.dart';

class MyEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyEventController());
  }
}
