// ProfileFunctions.dart

import 'dart:io';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/post_storage_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user_trans.dart';
import 'package:mudarribe_trainer/models/trainer_story.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/post_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:video_player/video_player.dart';

class StoryUploadFunctions {
  static Future<bool> validateVideoDuration(String filePath) async {
    VideoPlayerController controller =
        VideoPlayerController.file(File(filePath));
    await controller.initialize();

    Duration videoDuration = controller.value.duration;
    double durationInSeconds = videoDuration.inSeconds.toDouble();

    controller.dispose();

    return durationInSeconds <= 30.0;
  }

  static Future _saveStoryImage(
      PostStorageApi postStorageApi, File? storyImage, String storyId) async {
    if (storyImage != null) {
      final CloudStorageResult storageResult = await postStorageApi
          .uploadStoryImage(storyId: storyId, imageToUpload: storyImage);
      return storageResult;
    }
  }

  static Future addStory(
      PostService postService,
      UserService userService,
      BusyController busyController,
      File? storyImage,
      AppUserTransalted currentUser) async {
    busyController.setBusy(true);
    Get.offNamed(AppRoutes.profile);
    final storyId = DateTime.now().millisecondsSinceEpoch.toString();

    CloudStorageResult imageResult =
        await _saveStoryImage(PostStorageApi(), storyImage, storyId);
    if (imageResult.imageUrl != '') {
      await postService.createStory(
        story: TrainerStory(
          id: storyId,
          trainerId: currentUser.id,
          imageFileName: imageResult.imageFileName,
          imageUrl: imageResult.imageUrl,
          mediaType: MediaType.image,
          postedTime: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );

      storyImage = null;

      UiUtilites.successAlert(Get.context, 'Story Created'.tr);

      busyController.setBusy(false);
    }
  }

  static Future addCameraStory(
      PostService postService,
      BusyController busyController,
      File? storyImage,
      AppUserTransalted currentUser) async {
    busyController.setBusy(true);
    Get.back();
    final storyId = DateTime.now().millisecondsSinceEpoch.toString();

    CloudStorageResult imageResult =
        await _saveStoryImage(PostStorageApi(), storyImage, storyId);
    if (imageResult.imageUrl != '') {
      await postService.createStory(
        story: TrainerStory(
          id: storyId,
          trainerId: currentUser.id,
          imageFileName: imageResult.imageFileName,
          imageUrl: imageResult.imageUrl,
          mediaType: MediaType.image,
          postedTime: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );

      storyImage = null;

      UiUtilites.successAlert(Get.context, 'Story Created'.tr);

      busyController.setBusy(false);
    }
  }

  static Future addVideoStory(
      PostService postService,
      BusyController busyController,
      File? storyImage,
      AppUserTransalted currentUser) async {
    busyController.setBusy(true);
    bool isValidDuration = await validateVideoDuration(storyImage!.path);
    Get.back();
    if (isValidDuration) {
      final storyId = DateTime.now().millisecondsSinceEpoch.toString();

      CloudStorageResult imageResult =
          await _saveStoryImage(PostStorageApi(), storyImage, storyId);
      if (imageResult.imageUrl != '') {
        await postService.createStory(
          story: TrainerStory(
            id: storyId,
            trainerId: currentUser.id,
            imageFileName: imageResult.imageFileName,
            imageUrl: imageResult.imageUrl,
            mediaType: MediaType.video,
            postedTime: DateTime.now().millisecondsSinceEpoch.toString(),
          ),
        );

        storyImage = null;

        UiUtilites.successAlert(Get.context, 'Story Created'.tr);

        busyController.setBusy(false);
      }
    } else {
      UiUtilites.errorSnackbar(
        'Error'.tr,
        'Duration must not be greater than 30 Seconds.'.tr,
      );
      busyController.setBusy(false);
    }
  }
}
