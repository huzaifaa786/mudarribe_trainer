import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/story_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_story.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:path/path.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';

class TrainerStoryContoller extends GetxController {
  static TrainerStoryContoller instance = Get.find();
  final StoryController storyController = StoryController();
  final BusyController busyController = BusyController();
  final _homeApi = StoryApi();
  RxList<TrainerStory> firebaseStories = <TrainerStory>[].obs;
  RxList<StoryItem> stories = <StoryItem>[].obs;
  String currentIndex = "0";

  Rx<AppUser>? trainer;

  Future<void> getTrainerStories(id) async {
    firebaseStories = <TrainerStory>[].obs;
    stories = <StoryItem>[].obs;
    trainer = await _homeApi.fetchTrainerData(id).then((value) => value.obs);
    firebaseStories =
        await _homeApi.fetchTrainerStoryData(id).then((value) => value.obs);
    for (var story in firebaseStories) {
      stories.add(StoryItem.inlineImage(
          key: Key(story.id.toString()),
          url: story.imageUrl!,
          controller: storyController,
          roundedBottom: false,
          roundedTop: false));
    }

    update();
  }

  extractTimeAgo(String input) {
    RegExp regex = RegExp(r"\d+"); // Matches one or more digits

    Match? match = regex.firstMatch(input);
    if (match != null) {
      String id = match.group(0)!;
      return id;
    } else {
      return null;
    }
  }

  deletStory() async {
    busyController.setBusy(true);

    await _homeApi.deleteStory(currentIndex);

    Get.offAndToNamed(AppRoutes.homeScreen);
    firebaseStories = <TrainerStory>[].obs;
    stories = <StoryItem>[].obs;
    storyController.play();
    print(
        'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    print(stories.length);
    print(firebaseStories.length);
    // await getTrainerStories(trainer!.value.id);
    UiUtilites.successAlert(Get.context, "Story deleted successfully");
  }
}
