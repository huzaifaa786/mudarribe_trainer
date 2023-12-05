import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';

class PlanFileApi {
  static final _firestore = FirebaseFirestore.instance;
  final CollectionReference _trainerplanfileCollection =
      _firestore.collection("planfiles");

  createPlanFile(planfile) async {
    try {
      await _trainerplanfileCollection.doc(planfile.id).set(planfile.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create package',
        message: e.message,
      );
    }
  }
}
