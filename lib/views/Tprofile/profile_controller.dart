import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();

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

  onclick() {
    print(selected);
    selected = 'click';
    update();
  }




}