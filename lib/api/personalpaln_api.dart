import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/personal_plan.dart';


class PersonalPlanApi {
   static final _firestore = FirebaseFirestore.instance;
   final CollectionReference _trainerpersonalpalnCollection =
      _firestore.collection("personalplans");

      Future<void> createpersonalPlan(PersonalPlan personalPlan) async {
    try {
      await _trainerpersonalpalnCollection.doc(personalPlan.id).set(personalPlan.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create package',
        message: e.message,
      );
    }
  }

}