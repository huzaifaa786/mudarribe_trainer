import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/plan_file.dart';
import 'package:mudarribe_trainer/services/planfile_service.dart';

class ExistingPlanController extends GetxController {
  static ExistingPlanController instance = Get.find();

  final BusyController busyController = Get.find();
  List<PlanFile> planfiles = [];
  String planId = '';
  final _planfileService = PlanFileService();

  Future getTrainerFiles() async {
    planfiles = await _planfileService.getTrainerFiles(planId: planId);
    update();
    // busyController.setBusy(false);
  }
}
