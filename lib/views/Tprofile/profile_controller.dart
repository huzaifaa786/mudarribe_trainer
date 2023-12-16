import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/post_storage_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';
import 'package:mudarribe_trainer/models/trainer_story.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/post_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  final BusyController busyController = Get.find();
  final _postService = PostService();
  final _postStorageApi = PostStorageApi();

  List<TrainerPost> posts = [];
  File? storyImage;

  String selected = '';
  ontap() {
    print(selected);
    selected = 'click';
    update();
  }

  onclick() {
    print(selected);
    selected = 'click';
    update();
  }

  final _userService = UserService();
  AppUser? currentUser;

  @override
  void onInit() {
    getAppUser();

    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
      update();
      getTrainerPosts();
    }
  }

  Future _saveStoryImage(storyId) async {
    if (storyImage != null) {
      final CloudStorageResult storageResult = await _postStorageApi
          .uploadStoryImage(storyId: storyId, imageToUpload: storyImage!);
      return storageResult;
    }
  }

  Future addStory(String url) async {
    busyController.setBusy(true);
    storyImage = File(url);
    final storyId = DateTime.now().millisecondsSinceEpoch.toString();

    CloudStorageResult imageResult = await _saveStoryImage(storyId);
    if (imageResult.imageUrl != '') {
      await _postService.createStory(
          story: TrainerStory(
              id: storyId,
              trainerId: currentUser!.id,
              imageFileName: imageResult.imageFileName,
              imageUrl: imageResult.imageUrl,
              mediaType: MediaType.image,
              postedTime: DateTime.now().millisecondsSinceEpoch.toString()));

      storyImage = null;

      UiUtilites.successSnackbar(
          'Story has been created successfully', 'Story Created');
      Get.toNamed(AppRoutes.profile);
      busyController.setBusy(false);
    }
  }

  Future getTrainerPosts() async {
    busyController.setBusy(true);
    posts = await _postService.getTrainerPosts(trainerId: currentUser!.id);
    print(posts);
    update();
    busyController.setBusy(false);
  }
}
