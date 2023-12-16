import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  //  Future<List<Plan>> getPlansByTrainerAndCategory(String trainerId, String category) async {
  //   try {
  //     // Use where clause to filter plans based on trainerId and category
  //     QuerySnapshot querySnapshot = await _trainerpalnCollection
  //         .where('trainerId', isEqualTo: trainerId)
  //         .where('category', isEqualTo: category)
  //         .get();

  //     // Convert documents to a list of Plan objects
  //     List<Plan> plans = querySnapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       return Plan.fromJson(data);
  //     }).toList();

  //     return plans;
  //   } on PlatformException catch (e) {
  //     throw DatabaseApiException(
  //       title: 'Failed to get plans',
  //       message: e.message,
  //     );
  //   }
  // }
  Future<List<Plan>> getPlansByTrainerAndCategory(trainerId, category) async {
    try {
      log(trainerId);
      log(category);
      log('fffffffffffffffffffffffffffffffff');
      final result = await _trainerpalnCollection
          .where('trainerId', isEqualTo: trainerId)
          .where('category', isEqualTo: category)
          .get();

      final packages = result.docs
          .map(
            (e) => Plan.fromJson(e.data()! as Map<String, dynamic>),
          )
          .toList();

      return packages;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to Get Plans',
        message: e.message,
      );
    }
  }
}
