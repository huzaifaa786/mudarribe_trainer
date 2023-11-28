import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/services/user_service.dart';

class AddPlanController extends GetxController {
  static AddPlanController instance = Get.find();
  TextEditingController packagenameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  
  final _authApi = AuthApi();
  AppUser? currentUser;
  final _userService = UserService();

  String categary = '';

  onnutritiontap() {
    categary = 'nutrition';
    update();
    return categary;
  }

  onexcercisetap() {
    categary = 'excercise';
    update();
    return categary;
  }

  onbothtap() {
    categary = 'excercise & nutrition';
    update();
    return categary;
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();

      update();
    }
  }

  @override
  void onInit() {
    getAppUser();
    packagenameController.addListener(() {
      checkFields();
    });
    priceController.addListener(() {
      checkFields();
    });
    durationController.addListener(() {
      checkFields();
    });
    discriptionController.addListener(() {
      checkFields();
    });
    super.onInit();
  }

  void checkFields() {
    if (packagenameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        discriptionController.text.isNotEmpty&&
        categary != ''
        ) {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future<void> addpackage() async {
    if (areFieldsFilled.value) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        DocumentReference promoCodeRef = firestore.collection('packages').doc();

        Map<String, dynamic> data = {
          'id': currentUser!.id,
          'packagename': packagenameController.text,
          'price': priceController.text,
          'duration': durationController.text,
          'discription': discriptionController.text,
          'categary': categary
        };
        await promoCodeRef.set(data);
        packagenameController.clear();
        priceController.clear();
        durationController.clear();
        discriptionController.clear();
      } catch (error) {
        print('Error storing promo code: $error');
      }
    }
  }
}
