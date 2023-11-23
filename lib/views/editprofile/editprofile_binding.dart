import 'package:get/get.dart';
import 'package:mudarribe_trainer/views/editprofile/editprofile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileContoller());
  }
}
