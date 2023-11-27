import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/Tprofile/addpost_controller.dart';


class AddPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPostController());
  }
}
