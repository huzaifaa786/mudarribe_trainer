import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/banner_charges.dart';

class BannerApi {
  static final _firestore = FirebaseFirestore.instance;
  final CollectionReference _bannerChargesCollection =
      _firestore.collection("banner_charges");

  Future<BannerCharges> getBannerCharges() async {
    try {
      QueryDocumentSnapshot docSnapshot = await _bannerChargesCollection
          .limit(1)
          .get()
          .then((value) => value.docs[0]);

      return BannerCharges.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create package',
        message: e.message,
      );
    }
  }
}
