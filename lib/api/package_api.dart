

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






}