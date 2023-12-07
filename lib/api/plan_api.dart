import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/plan.dart';

class PlanApi {
  static final _firestore = FirebaseFirestore.instance;
  final CollectionReference _trainerpalnCollection =
      _firestore.collection("plans");

  Future<void> createPlan(Plan plan) async {
    try {
      await _trainerpalnCollection.doc(plan.id).set(plan.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create plan',
        message: e.message,
      );
    }
  }
}
