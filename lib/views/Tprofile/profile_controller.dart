import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/file_selector_api.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/api/post_storage_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/app_user_trans.dart';
import 'package:mudarribe_trainer/models/trainer_post.dart';
import 'package:mudarribe_trainer/models/trainer_story.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/post_service.dart';
import 'package:mudarribe_trainer/services/story_services.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  final BusyController busyController = Get.find();
  final _postService = PostService();
  final _postStorageApi = PostStorageApi();
  final _imageSelectorApi = ImageSelectorApi();
  final _fileSelectorApi = FileSelectorApi();

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
  AppUserTransalted? currentUser;

  @override
  void onInit() {
    getAppUser();

    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser1();
      update();
      getTrainerPosts();
    }
  }

  Future selectStoryImage() async {
    Get.back();
    final tempImage = await _imageSelectorApi.selectCameraImage();
    if (tempImage != null) {
      storyImage = tempImage;
      addCameraStory();
    }
    update();
  }

  Future selectStoryMp4() async {
    Get.back();
    final tempImage = await _fileSelectorApi.selectMp4Files();
    if (tempImage != null) {
      storyImage = tempImage;
      update();
      addVideoStory();
    }
    update();
  }

  Future<bool> validateVideoDuration(String filePath) async {
    VideoPlayerController controller =
        VideoPlayerController.file(File(filePath));
    await controller.initialize();

    Duration videoDuration = controller.value.duration;
    double durationInSeconds = videoDuration.inSeconds.toDouble();

    controller.dispose();

    return durationInSeconds <= 30.0;
  }

  Future _saveStoryImage(storyId) async {
    if (storyImage != null) {
      final CloudStorageResult storageResult = await _postStorageApi
          .uploadStoryImage(storyId: storyId, imageToUpload: storyImage!);
      return storageResult;
    }
  }

  Future addStory(String url) async {
    Get.offNamed(AppRoutes.profile);
    storyImage = File(url);
    update();
    await StoryUploadFunctions.addStory(
        _postService, _userService, busyController, storyImage, currentUser!);
    storyImage = null;
    update();
  }

  //! Camera Image Story Upload Function
  Future addCameraStory() async {
    await StoryUploadFunctions.addCameraStory(
        _postService, busyController, storyImage, currentUser!);
    storyImage = null;
    update();
  }

  //! Video Story Upload Function
  Future addVideoStory() async {
    await StoryUploadFunctions.addVideoStory(
        _postService, busyController, storyImage, currentUser!);
    storyImage = null;
    update();
  }

  Future getTrainerPosts() async {
    busyController.setBusy(true);
    posts = await _postService.getTrainerPosts(trainerId: currentUser!.id);
    print(posts);
    update();
    busyController.setBusy(false);
  }
}
