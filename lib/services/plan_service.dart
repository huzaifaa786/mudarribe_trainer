import 'package:mudarribe_trainer/api/plan_api.dart';
import 'package:mudarribe_trainer/models/plan.dart';

class PlanService {
  final _planApi = PlanApi();

  Future<void> createPlan({required Plan plan}) async {
    await _planApi.createPlan(plan);
  }

  // Future<List<Plan>> getPlans(trainerIds, categorys) async {
  //   return await _planApi.getPlansByTrainerAndCategory(trainerIds, categorys);
  // }

  Future<List<Plan>> getTrainerPlans(
      {required trainerId, required category, required traineeId, required orderId}) async {
    return await _planApi.getPlansByTrainerAndCategory(trainerId, category, traineeId, orderId);
  }
}
