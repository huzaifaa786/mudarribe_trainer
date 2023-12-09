

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/services/package_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class PackageController extends GetxController {
  static PackageController instance = Get.find();
  final BusyController busyController = Get.find();

  final _packageService = PackageService();

  List<Package> packages = [];
  final _userService = UserService();
  AppUser? currentUser;

  @override
  void onInit() {
    getAppUser();

    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
      getTrainerPackages();
    }
    update();
  }

  Future getTrainerPackages() async {
    busyController.setBusy(true);
    packages =
        await _packageService.getTrainerPackages(trainerId: currentUser!.id);

    update();

    busyController.setBusy(false);
   
  }

  deletePackageById(String id) async {
    await _packageService.deletePackage(id: id);
    getTrainerPackages();
    Get.back();
    UiUtilites.successAlert(
        Get.context, 'Package deleted successfully');
  }
}
