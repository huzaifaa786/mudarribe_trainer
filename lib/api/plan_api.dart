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
  final CollectionReference _trainerFilesCollection =
      _firestore.collection("trainer_plan_files");
  final CollectionReference _userPersonalPlanCollection =
      _firestore.collection("user_personal_plans");

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

  Future<Plan?> getPlanById(String planId) async {
    try {
      final result = await _trainerpalnCollection.doc(planId).get();
      if (result.exists) {
        String fileLength = '0';
        String videoLength = '0';
        final planData = result.data() as Map<String, dynamic>;

        final fileResult = await _trainerFilesCollection
            .where('planId', isEqualTo: result.id)
            .where('fileType', isEqualTo: 'pdf')
            .get();

        final videoResult = await _trainerFilesCollection
            .where('planId', isEqualTo: result.id)
            .where('fileType', isEqualTo: 'mp4')
            .get();
        if (fileResult.docs.isNotEmpty || videoResult.docs.isNotEmpty) {
          fileLength = fileResult.docs.length.toString();
          videoLength = videoResult.docs.length.toString();
        }
        planData['description'] = '$fileLength Files ,$videoLength videos';

        return Plan.fromJson(planData);
      } else {
        return null; // Plan with given ID not found
      }
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to get package by ID',
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

  Future<void> sendPlan(planId,plan) async {
      try {
      await _userPersonalPlanCollection.doc(planId).set(plan);
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create plan',
        message: e.message,
      );
    }
  }
  Future<List<Plan>> getPlansByTrainerAndCategory(trainerId, category) async {
    try {
      final result = await _trainerpalnCollection
          .where('trainerId', isEqualTo: trainerId)
          .where('category', isEqualTo: category)
          .get();
      List<Plan> plans = [];
      for (var doc in result.docs) {
        String fileLength = '0';
        String videoLength = '0';
        final planData = doc.data() as Map<String, dynamic>;

        final fileResult = await _trainerFilesCollection
            .where('planId', isEqualTo: doc.id)
            .where('fileType', isEqualTo: 'pdf')
            .get();

        final videoResult = await _trainerFilesCollection
            .where('planId', isEqualTo: doc.id)
            .where('fileType', isEqualTo: 'mp4')
            .get();
        if (fileResult.docs.isNotEmpty || videoResult.docs.isNotEmpty) {
          fileLength = fileResult.docs.length.toString();
          videoLength = videoResult.docs.length.toString();
        }
        planData['description'] = '$fileLength Files ,$videoLength videos';
        plans.add(Plan.fromJson(planData));
      }

      return plans;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to Get Plans',
        message: e.message,
      );
    }
  }
}
