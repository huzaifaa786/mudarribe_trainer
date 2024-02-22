import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/order/order_controllers.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}
