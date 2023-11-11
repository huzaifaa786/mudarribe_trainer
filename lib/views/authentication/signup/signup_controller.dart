import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SigninController extends GetxController {
  static SigninController instance = Get.find();
  String selected = '';
  onfemaletap() {
    selected = 'female';
    update();
    return selected;
  }

  onmaletap() {
    selected = 'male';
    update();
    return selected;
  }

  onclick() {
    selected = 'click';
    print(selected);
    update();
  }

  bool obscureTextPassword = true;
  bool obscureTextCPassword = true;
  void toggle() {
    obscureTextPassword = !obscureTextPassword;
    update();
  }

  void toggle1() {
    obscureTextCPassword = !obscureTextCPassword;
    update();
  }

  XFile? profileImage = XFile('');
  Future<void> selectProfileImage() async {
     final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = image;
      // certificateName.text = certificateImage!.name;
      update();
    } else {
      profileImage = XFile('');
      update();
    }
  }
}
