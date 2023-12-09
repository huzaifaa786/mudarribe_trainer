import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/file_selector_api.dart';
import 'package:mudarribe_trainer/api/plan_storage_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/plan.dart';
import 'package:mudarribe_trainer/models/plan_file.dart';
import 'package:mudarribe_trainer/services/plan_service.dart';
import 'package:mudarribe_trainer/services/planfile_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:path/path.dart';

class ExercisesController extends GetxController {
  static ExercisesController instance = Get.find();

  final BusyController busyController = Get.find();

  TextEditingController filenameController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  final _fileSelectorApi = FileSelectorApi();
  String category = '';
  List<Plan> plans = [];
  List<File> selectedFiles = [];
  final _authApi = AuthApi();
  AppUser? currentUser;
  final _userService = UserService();
  final _planService = PlanService();
  final _planfileService = PlanFileService();
  final _planfileStorageApi = PlanStorageApi();
  String selectedPlan='';

  void checkFields() {
    if (filenameController.text.isNotEmpty) {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();

      update();
       getTrainerPlan();
    }
  }
changePlan(value){
selectedPlan =value;
update();



}
  Future selectmultipleFiles() async {
    final tempFile = await _fileSelectorApi.selectMultipleFiles();
    selectedFiles = tempFile;
    update();

    if (selectedFiles != []) {
      addplan();
    }
    checkFields();
  }

  void onInit() {
    getAppUser();
   

    super.onInit();
  }

////////////////////////plan////////////////////////////////
  Future addplan() async {
    busyController.setBusy(true);
    final planId = DateTime.now().millisecondsSinceEpoch.toString();

    await _planService.createPlan(
        plan: Plan(
            id: planId,
            trainerId: currentUser!.id,
            name: filenameController.text,
            category: category));

    filenameController.clear();

    category = '';
    areFieldsFilled.value = false;

    await storeplanfiles(planId);
    busyController.setBusy(false);
  }

//////////////////////////////////file////////////////////////////////////

  Future storeplanfiles(planId) async {
    for (File file in selectedFiles) {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final fileExtension = extension(file.path);
      final fileName = basenameWithoutExtension(file.path);
      CloudStorageResult cloudStorageResult = await _planfileStorageApi
          .uploadPlanFile(planFileId: id, fileToUpload: file);
      _planfileService.createPlanFile(
          planfile: PlanFile(
              id: id,
              planId: planId,
              fileType: fileExtension == '.pdf' ? FileType.pdf : FileType.mp4,
              fileName: fileName,
              fileUrl: cloudStorageResult.imageUrl,
              FileId: cloudStorageResult.imageFileName));
    }
    Get.back();
    UiUtilites.successAlert(Get.context, 'Package Added\nSuccessfully !');
  }

  Future getTrainerPlan() async {

    plans = await _planService.getTrainerPlans(
        category: category, trainerId: currentUser!.id);
        print(currentUser!.id);
        print(category);
        print('ffffffffffffffffffffffffffffffffff');
    update();
  
    print(plans);
   
  }
}
