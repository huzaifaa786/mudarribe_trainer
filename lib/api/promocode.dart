import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/promocode.dart';

class PromoCodeApi{


   static final _firestore = FirebaseFirestore.instance;
   final CollectionReference _trainerpromocodeCollection =
      _firestore.collection("promocodes");

      Future<void> createpromocode(PromoCode promocode) async {
    try {
      await _trainerpromocodeCollection.doc(promocode.id).set(promocode.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create package',
        message: e.message,
      );
    }
  }

}

