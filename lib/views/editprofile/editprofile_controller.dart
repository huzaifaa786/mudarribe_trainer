import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/api/storage_api.dart';
import 'package:mudarribe_trainer/exceptions/auth_api_exception.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class EditProfileContoller extends GetxController {
  static EditProfileContoller instance = Get.find();
  final BusyController busyController = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final _imageSelectorApi = ImageSelectorApi();

  final _storageApi = StorageApi();
  final _authApi = AuthApi();

  final _userService = UserService();
  AppUser? currentUser;
  List<String> selectedCategories = [];
  RxBool areFieldsFilled = false.obs;
  File? profileImage;

  @override
  void onInit() {
    getAppUser();
    nameController.addListener(() {
      checkFields();
    });
    super.onInit();
  }

  onchange(List<dynamic> x) {
    selectedCategories = x.cast<String>();
    checkFields();
    update();
  }

  void checkFields() {
    if (nameController.text.isNotEmpty && selectedCategories != []) {
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

  Future selectProfileImage() async {
    final tempImage = await _imageSelectorApi.selectImage();
    profileImage = tempImage;
    checkFields();
    update();
  }

  Future updateProfileImg(AppUser appUser) async {
    if (profileImage != null) {
      if (currentUser!.profileImageUrl != null) {
        final result = await _storageApi.deleteProfileImage(
            userId: currentUser!.id,
            fileName: currentUser!.profileImageFileName!);
        if (result) {
          final CloudStorageResult storageResult =
              await _storageApi.uploadProfileImage(
                  userId: currentUser!.id, imageToUpload: profileImage!);
          return storageResult;
        }
      }
    }
  }

  Future updateTrainer() async {
    busyController.setBusy(true);
    if (profileImage != null) {
      CloudStorageResult? imageResult = await updateProfileImg(currentUser!);
      if (imageResult!.imageUrl != '') {
        await _userService.updateUser(id: currentUser!.id, user: {
          'name': nameController.text,
          'bio': bioController.text,
          'profileImageFileName': imageResult.imageFileName,
          'profileImageUrl': imageResult.imageUrl,
          'categories': selectedCategories,
        });
        UiUtilites.successSnackbar('', 'User updated successfully');
      }
    } else {
      await _userService.updateUser(
        id: currentUser!.id,
        user: {
          'name': nameController.text,
          'bio': bioController.text,
          'categories': selectedCategories,
        },
      );
      UiUtilites.successSnackbar('', 'User updated successfully');
    }
    busyController.setBusy(false);
  }

  Future logout() async {
    try {
      await _authApi.logout();

      Get.offAllNamed(AppRoutes.signin);
    } on AuthApiException catch (e) {
      UiUtilites.errorSnackbar('Logout Failed', e.toString());
    }
  }
}
