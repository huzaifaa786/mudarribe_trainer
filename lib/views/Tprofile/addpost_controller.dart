import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/api/post_storage_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/post_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class AddPostController extends GetxController {
  static AddPostController instance = Get.find();
  final BusyController busyController = Get.find();
  final _imageSelectorApi = ImageSelectorApi();
  final _postService = PostService();
  final _postStorageApi = PostStorageApi();
  TextEditingController captionController = TextEditingController();

  final _userService = UserService();
  AppUser? currentUser;
  File? postImage;
  RxBool areFieldsFilled = false.obs;

  @override
  void onInit() {
    getAppUser();
    super.onInit();
  }

  void checkFields() {
    if (postImage != null) {
      areFieldsFilled.value = true;
    } else {
      areFieldsFilled.value = false;
    }
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
    }
    update();
  }

  Future selectPostImage() async {
    final tempImage = await _imageSelectorApi.selectImage();
    postImage = tempImage;
    checkFields();
    update();
  }

  Future _savePostImage(postId) async {
    if (postImage != null) {
      final CloudStorageResult storageResult = await _postStorageApi
          .uploadPostImage(postId: postId, imageToUpload: postImage!);
      return storageResult;
    }
  }

  Future createPost() async {
    busyController.setBusy(true);
    final postId = DateTime.now().millisecondsSinceEpoch.toString();

    CloudStorageResult imageResult = await _savePostImage(postId);
    if (imageResult.imageUrl != '') {
      await _postService.createPost(
          post: TrainerPost(
              id: postId,
              caption: captionController.text,
              trainerId: currentUser!.id,
              imageFileName: imageResult.imageFileName,
              imageUrl: imageResult.imageUrl,
              mediaType: MediaType.image));
      captionController.clear();
      postImage = null;
      areFieldsFilled = true.obs;
      update();

      busyController.setBusy(false);
      UiUtilites.successSnackbar(
          'Post has been created successfully', 'Post Created');
    }
  }
}
