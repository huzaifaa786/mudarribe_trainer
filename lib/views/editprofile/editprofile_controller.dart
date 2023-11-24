import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/services/user_service.dart';

class EditProfileContoller extends GetxController {
  static EditProfileContoller instance = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final _userService = UserService();
  AppUser? currentUser;
  List<String> selectedCategories = [];
  RxBool areFieldsFilled = false.obs;
  File? profileImage;


  @override
  void onInit() {
    getAppUser();
    super.onInit();
  }

  onchange(List<dynamic> x) {
    selectedCategories = x.cast<String>();
    checkFields();
    update();
  }


  void checkFields() {
    if (nameController.text.isNotEmpty &&
        profileImage != null &&
        selectedCategories != []) {
      areFieldsFilled.value = true;
    } else {
      areFieldsFilled.value = false;
    }
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
      nameController.text = currentUser!.name!;
      bioController.text = currentUser!.bio!;
      selectedCategories = currentUser!.categories!;
      update();
    }
 
  }
}
