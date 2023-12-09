import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/plan_file.dart';

class PlanFileApi {
  static final _firestore = FirebaseFirestore.instance;
  final CollectionReference _trainerplanfileCollection =
      _firestore.collection("trainer_plan_files");

    Future<void> createPlanFile(PlanFile planfile) async {
    try {
      await _trainerplanfileCollection.doc(planfile.id).set(planfile.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create Plan',
        message: e.message,
      );
    }
  }
}
