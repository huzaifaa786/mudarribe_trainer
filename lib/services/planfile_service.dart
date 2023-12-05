import 'package:mudarribe_trainer/api/planfile_api.dart';
import 'package:mudarribe_trainer/models/plan_file.dart';

class PlanFileService {
  final _planFileApi = PlanFileApi();

  Future<void> createPlanFile({required PlanFile planfile}) async {
    await _planFileApi.createPlanFile(planfile);
  }
}