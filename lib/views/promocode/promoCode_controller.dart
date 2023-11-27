import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoCodeContoller extends GetxController {
  static PromoCodeContoller instance = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController percentagecontroller = TextEditingController();
  String? id;
  RxBool areFieldsFilled = false.obs;

  @override
  void onInit() {
    nameController.addListener(() {
      checkFields();
    });
    percentagecontroller.addListener(() {
      checkFields();
    });

    super.onInit();
  }

  void checkFields() {
    if (nameController.text.isNotEmpty &&
        percentagecontroller.text.isNotEmpty) {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future<void> storePromocode() async {
    if (areFieldsFilled.value) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        DocumentReference promoCodeRef =
            firestore.collection('promocodes').doc();

        Map<String, dynamic> data = {
          'id': id,
          'name': nameController.text,
          'percentage': percentagecontroller.text,
        };
        await promoCodeRef.set(data);
        nameController.clear();
        percentagecontroller.clear();
      } catch (error) {
        print('Error storing promo code: $error');
      }
    }
  }
}
