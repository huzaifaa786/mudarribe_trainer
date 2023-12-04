import 'package:mudarribe_trainer/api/plan_api.dart';
import 'package:mudarribe_trainer/models/plan.dart';

class PlanService {
  final _planApi = PlanApi();

  Future<void> createPlan({required Plan plan}) async {
    await _planApi.createPlan(plan);
  }

}