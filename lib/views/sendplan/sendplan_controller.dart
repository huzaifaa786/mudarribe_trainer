import 'package:get/get.dart';

class SendPlanController extends GetxController {
  static SendPlanController instance = Get.find();


 String selected = '';
  onnutritiontap() {
    selected = 'nutrition';
    update();
    return selected;
  }

  onexcercisetap() {
    selected = 'excercise';
    update();
    return selected;
  }
   onclick() {
    selected = 'click';
    print(selected);
    update();
  }



}