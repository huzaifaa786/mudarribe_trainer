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
    trainer = await _homeApi.fetchTrainerData(id).then((value) => value.obs);
    firebaseStories =
        await _homeApi.fetchTrainerStoryData(id).then((value) => value.obs);
    for (var i = 0; i < firebaseStories.length; i++) {
      stories.add(StoryItem.inlineImage(
          key: Key(i.toString()),
          url: firebaseStories[i].imageUrl!,
          controller: storyController,
          roundedBottom: false,
          roundedTop: false));
      update();
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

    await _homeApi.deleteStory(firebaseStories[int.parse(currentIndex)].id);

    busyController.setBusy(false);
    refresh();
    Get.offNamed(AppRoutes.homeScreen);
    UiUtilites.successAlert(Get.context, "Story deleted successfully");
  }
}
