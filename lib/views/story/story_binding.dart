import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/story/story_controller.dart';




class TrainerStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerStoryContoller());
  }
}