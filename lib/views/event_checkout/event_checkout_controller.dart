import 'package:get/get.dart';

import 'package:mudarribe_trainer/views/event_checkout/event_checkout_view.dart';

class EventcheckoutController extends GetxController {
  static EventcheckoutController instance = Get.find();


  PaymentMethod? site;
  toggleplan(PaymentMethod value) {
    site = value;
    update();
  }

  @override
  void onInit() {
    site = PaymentMethod.visa;
    update();
    super.onInit();
  }


  
   var isButtonPressed = false.obs;

  void toggleButtonColor() {
    // Toggle the value when the button is pressed
    isButtonPressed.value = !isButtonPressed.value;
  }
}
