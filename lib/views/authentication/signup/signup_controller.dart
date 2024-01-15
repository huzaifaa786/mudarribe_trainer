// ignore_for_file: unused_field

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/database_api.dart';
import 'package:mudarribe_trainer/api/file_selector_api.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/api/storage_api.dart';
import 'package:mudarribe_trainer/exceptions/auth_api_exception.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/enums/enums.dart';

class SignUpController extends GetxController {
  static SignUpController instance = Get.find();
  final BusyController busyController = Get.find();
  final _databaseApi = DatabaseApi();
  final _storageApi = StorageApi();
  final _imageSelectorApi = ImageSelectorApi();
  final _fileSelectorApi = FileSelectorApi();
  final _authApi = AuthApi();
  final _userService = UserService();

  // text editing controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  // documents
  File? profileImage;
  File? certificate;
  File? passportId;

  // selectors
  String gender = '';
  List<String> selectedCategories = [];
  List<String> selectedLanguages = [];

  // listners

  RxBool areFieldsFilled = false.obs;

  onfemaletap() {
    gender = 'female';
    checkFields();
    update();
    return gender;
  }

  onchange(List<dynamic> x) {
    selectedCategories = x.cast<String>();
    checkFields();
    update();
  }

  onlangchange(List<dynamic> x) {
    selectedLanguages = x.cast<String>();
    checkFields();
    update();
  }

  onmaletap() {
    gender = 'male';
    checkFields();
    update();
    return gender;
  }

  bool obscureTextPassword = true;
  bool obscureTextCPassword = true;

  void togglePassword() {
    obscureTextPassword = !obscureTextPassword;
    update();
  }

  void toggleCPassword() {
    obscureTextCPassword = !obscureTextCPassword;
    update();
  }

  void checkFields() {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        profileImage != null &&
        certificate != null &&
        passportId != null &&
        selectedCategories != [] &&
        selectedLanguages != [] &&
        gender != '') {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() {
      checkFields();
    });
    emailController.addListener(() {
      checkFields();
    });
    passwordController.addListener(() {
      checkFields();
    });
    confirmPasswordController.addListener(() {
      checkFields();
    });
    bioController.addListener(() {
      checkFields();
    });
  }

  Future selectProfileImage() async {
    final tempImage = await _imageSelectorApi.selectImage();
    profileImage = tempImage;
    checkFields();
    update();
  }

  Future selectCertificate() async {
    final tempFile = await _fileSelectorApi.selectFile();
    certificate = tempFile;
    checkFields();
    update();
  }

  Future selectPassportId() async {
    final tempFile = await _fileSelectorApi.selectFile();
    passportId = tempFile;
    checkFields();
    update();
  }

  Future _saveCertificate(userId) async {
    if (certificate != null) {
      final CloudStorageResult storageResult = await _storageApi
          .uploadCertificate(userId: userId, certificate: certificate!);
      return storageResult;
    }
  }

  Future _savePassportId(userId) async {
    if (passportId != null) {
      final CloudStorageResult storageResult = await _storageApi
          .uploadPassportId(userId: userId, passport: passportId!);
      return storageResult;
    }
  }

  Future _saveProfileImage(userId) async {
    if (profileImage != null) {
      final CloudStorageResult storageResult = await _storageApi
          .uploadProfileImage(userId: userId, imageToUpload: profileImage!);
      return storageResult;
    }
  }

  Future signUpTrainer() async {
    busyController.setBusy(true);

    try {
      final User user = await _authApi.signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
      );

      if (user.uid.isNotEmpty && areFieldsFilled.value == true) {
        CloudStorageResult imageResult = await _saveProfileImage(user.uid);
        CloudStorageResult certificateResult = await _saveCertificate(user.uid);
        CloudStorageResult passportResult = await _savePassportId(user.uid);
        var token = await FirebaseMessaging.instance.getToken();
        await _userService.syncOrCreateUser(
          user: AppUser(
              id: user.uid,
              name: nameController.text,
              userType: 'trainer',
              email: user.email,
              bio: bioController.text,
              gender: gender,
              status: TrainerStatus.pending,
              profileImageFileName: imageResult.imageFileName,
              profileImageUrl: imageResult.imageUrl,
              certificateFileName: certificateResult.imageFileName,
              certificateUrl: certificateResult.imageUrl,
              passportIdFileName: passportResult.imageFileName,
              passportIdUrl: passportResult.imageUrl,
              categories: selectedCategories,
              languages: selectedLanguages,
              firebaseToken: token),
        );
        clearValues();
        Get.offNamed(AppRoutes.signin);
        UiUtilites.successAlert(
            Get.context, 'Application submitted successfully!');
      }
    } on AuthApiException catch (e) {
      UiUtilites.errorSnackbar('Signup Failed', e.toString());
    }
    busyController.setBusy(false);
  }

  clearValues() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    bioController.clear();
    searchController.clear();
    profileImage = null;
    certificate = null;
    passportId = null;
    gender = '';
    selectedCategories.clear();
    selectedLanguages.clear();
    areFieldsFilled.value = false;
  }
}
