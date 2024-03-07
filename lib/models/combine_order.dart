import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/order.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/models/personal_plan.dart';
import 'package:mudarribe_trainer/models/trainee_profile.dart';

class CombinedOrderData {
  final AppUser trainer;
  final TraineeProfile trainee;
  final TrainerOrder order;
  final Package? package;
  final PersonalPlan? personalPlan;
  final DocumentSnapshot lastdoc;
  final bool sent;

  CombinedOrderData({
    required this.trainer,
    required this.trainee,
    required this.order,
    this.package,
    this.personalPlan,
    required this.lastdoc,
    required this.sent
  });
}
