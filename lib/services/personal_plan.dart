import 'package:mudarribe_trainer/api/personalpaln_api.dart';
import 'package:mudarribe_trainer/models/personal_plan.dart';


class PersonalPlanService {
  final _personalpalnApi = PersonalPlanApi();


  Future<void> createpersonalPlan({required PersonalPlan personalPlan}) async {
    await _personalpalnApi.createpersonalPlan(personalPlan);
  }
}