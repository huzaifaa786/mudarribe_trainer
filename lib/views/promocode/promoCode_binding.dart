import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/promocode/promoCode_controller.dart';

class PromoCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromoCodeContoller());
  }
}