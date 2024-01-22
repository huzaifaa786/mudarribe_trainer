// ignore_for_file: body_might_complete_normally_nullable, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mudarribe_trainer/models/coupon_code.dart';

class CouponCodeApi {
  Future<CouponCode?> getCouponCode(String couponCode) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('coupon_code')
        .where('CouponCode', isEqualTo: couponCode)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return CouponCode.fromMap(
          querySnapshot.docs[0].data() as Map<String, dynamic>);
    }
  }
}
