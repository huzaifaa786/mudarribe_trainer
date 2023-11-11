import 'package:get/get.dart';

class PersonalPlanController extends GetxController {
  static PersonalPlanController instance = Get.find();

  RxList<String> gridItems = [
    'assets/images/post1.png',
    'assets/images/post2.png',
    'assets/images/post3.png',
    'assets/images/post4.png',
    'assets/images/post5.png',
    'assets/images/post6.png',
    'assets/images/post1.png',
    'assets/images/post2.png',
    'assets/images/post3.png',
    'assets/images/post4.png',
    'assets/images/post5.png',
    'assets/images/post6.png',
      'assets/images/post4.png',
    'assets/images/post5.png',
    'assets/images/post6.png',
  ].obs;
  String selected = '';
  ontap() {
    print(selected);
    selected = 'click';
    update();
  }






}