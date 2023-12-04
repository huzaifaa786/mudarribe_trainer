
import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/sendplan/exercises/exercises_controller.dart';


class ExercisesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExercisesController());
  }
}