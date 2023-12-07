
import 'package:get/get.dart';

import 'package:mudarribe_trainer/views/sendplan/nutrition/nutrition_controller.dart';


class NutritionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NutritionController());
  }
}