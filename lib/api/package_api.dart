

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/packages.dart';

class PackageApi {
   static final _firestore = FirebaseFirestore.instance;
   final CollectionReference _trainerPackagesCollection =
      _firestore.collection("packages");

  Future<void> createPackage(Package package) async {
    try {
      await _trainerPackagesCollection.doc(package.id).set(package.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create package',
        message: e.message,
      );
    }
  }
   Future<List<Package>> getTrainerPackages(trainerId) async {
    try {
      log('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqdfdggfgfgqqqqq');
      log(trainerId);
      final result = await _trainerPackagesCollection.get();

      final packages = result.docs
          .map(
            (e) => Package.fromJson(e.data()! as Map<String, dynamic>),
          )
          // .where((item) => item.trainerId == trainerId)
          .toList();

      return packages;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create package',
        message: e.message,
      );
    }
  }
 Future<Package?> getPackageById(String packageId) async {
    try {
      final result =
          await _trainerPackagesCollection.doc(packageId).get();

      if (result.exists) {
        return Package.fromJson(result.data()! as Map<String, dynamic>);
      } else {
        return null; // Package with given ID not found
      }
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to get package by ID',
        message: e.message,
      );
    }
  }
    Future<void> updatePackage(id, Package) async {
    try {
      await _trainerPackagesCollection.doc(id).update(Package);
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to update Package',
        message: e.message,
      );
    }
  }




  

  Future<void> deletePackage(id) async {
    try {
      await _trainerPackagesCollection.doc(id).delete();
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to delete package',
        message: e.message,
      );
    }
  }

  
}







