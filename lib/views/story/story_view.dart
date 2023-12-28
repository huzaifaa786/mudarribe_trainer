import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/story/story_controller.dart';

import 'package:story_view/story_view.dart';

class StoriesView extends StatefulWidget {
  const StoriesView({super.key});

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  @override
  Widget build(BuildContext context) {
    String id = Get.parameters['trainer_id'].toString();
    return GetBuilder<TrainerStoryContoller>(

      initState: (state) async {
        Future.delayed(const Duration(milliseconds: 100), () {
          state.controller!.getTrainerStories(id);
        });
      },
      builder: (controller) => controller.trainer != null
          ? BusyIndicator(
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  forceMaterialTransparency: true,
                  title:controller.stories.isNotEmpty ? Text(''):TopBar(text: "",),
                ),
                body: SafeArea(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: Get.width,
                    child: controller.stories.isNotEmpty
                        ? Stack(
                            children: [
                              StoryView(
                                controller: controller.storyController,
                                storyItems: controller.stories,
                                onComplete: () {},
                                onStoryShow: (StoryItem story) {
                                  controller.currentIndex = controller
                                      .extractTimeAgo(story.view.key.toString());
                                  print(controller.currentIndex);
                                },
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: SizedBox(
                                  width: Get.width,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 52,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: GradientBoxBorder(
                                              gradient: LinearGradient(colors: [
                                                Color(4290773187),
                                                Color(4285693389),
                                                Color.fromARGB(255, 32, 68, 65)
                                              ]),
                                              width: 2,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(controller
                                                      .trainer!
                                                      .value
                                                      .profileImageUrl!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 13),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  controller.trainer!.value.name!,
                                                  style: const TextStyle(
                                                      color: white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
          
                                                // Padding(
                                                //   padding: const EdgeInsets.only(left: 3),
                                                //   child: Text(
                                                //     controller.extractTimeAgo(
                                                //         controller.time.value),
                                                //     style: const TextStyle(
                                                //         color: Colors.grey,
                                                //         fontSize: 14,
                                                //         fontWeight: FontWeight.w600),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 20,
                                  right: 15,
                                  child: InkWell(
                                    onTap: () {
                                      controller.storyController.pause();
                                      UiUtilites.confirmStoryAlert(
                                          context, "Are you sure to delete story",
                                          () {
                                        controller.deletStory();
                                      }, () {
                                        Get.back();
                                        controller.storyController.play();
                                      }, "Delete", "Cancel");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.delete),
                                    ),
                                  ))
                            ],
                          )
                        : Center(child: Text('No Story Uploaded'))),
              )),
          )
          : const BasicLoader(),
    );
  }
}
