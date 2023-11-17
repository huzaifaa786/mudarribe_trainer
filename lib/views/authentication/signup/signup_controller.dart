import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/auth_api.dart';
import 'package:mudarribe_trainer/api/database_api.dart';
import 'package:mudarribe_trainer/api/file_selector_api.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/api/storage_api.dart';
import 'package:mudarribe_trainer/exceptions/auth_api_exception.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class SignUpController extends GetxController {
  static SignUpController instance = Get.find();
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

  // documents
  File? profileImage;
  File? certificate;
  File? passportId;

  // selectors
  String gender = '';
  List selectedCategories = [];
  List selectedLanguages = [];

  // listners

  RxBool areFieldsFilled = false.obs;

  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String selected = '';
  onfemaletap() {
    selected = 'female';
    update();
    return selected;
  }

  onmaletap() {
    selected = 'male';
    update();
    return selected;
  }

  onclick() {
    selected = 'click';
    print(selected);
    update();
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
        profileImage != null) {
      areFieldsFilled.value = true;
    } else {
      areFieldsFilled.value = false;
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

  Future signUpTrainer() async {
    try {
      final User user = await _authApi.signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
      );

      if (user.uid.isNotEmpty) {
        await _userService.syncOrCreateUser(
          user: AppUser(
              id: user.uid,
              userType: 'trainer',
              email: user.email,
              bio: bioController.text,
              gender: gender,
              ),
        );
        UiUtilites.successSnackbar(
            'Register User', 'User registered successfully & sent for approval');
        // Get.offNamed(AppRoutes.footer);
      }
    } on AuthApiException catch (e) {
      UiUtilites.errorSnackbar('Signup Failed', e.toString());
    }
  }
}
