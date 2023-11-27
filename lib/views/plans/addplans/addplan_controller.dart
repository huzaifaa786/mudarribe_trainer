import 'package:get/get.dart';

class AddPlanController extends GetxController {
  static AddPlanController instance = Get.find();

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
   onbothtap() {
    selected = 'both';
    update();
    return selected;
  }

  onclick() {
    selected = 'click';
    print(selected);
    update();
  }
}
