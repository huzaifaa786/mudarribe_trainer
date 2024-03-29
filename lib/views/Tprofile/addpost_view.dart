// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/Tprofile/addpost_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(
      builder: (controller) => controller.currentUser != null ? BusyIndicator(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold( appBar: AppBar(
                forceMaterialTransparency: true,
                automaticallyImplyLeading: false,
                title: TitleTopBar(
                  name: 'New Post'.tr,
                  ontap: () {
                    Get.back();
                  },
                ),
              ),
                  body: SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                        children: [
                          
                          SizedBox(
                            height: 27,
                          ),
                          InkWell(
                            onTap: () {
                              controller.selectPostImage();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 390,
                              decoration: BoxDecoration(),
                              child: controller.postImage != null
                                  ? Container(
                                    decoration: BoxDecoration(border: GradientBoxBorder(
                            
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                        colors: [borderTop,borderbottom]),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
                                    child: Image.file(
                                        controller.postImage!
                                      ),
                                  )
                                  : Container(
                                    decoration: BoxDecoration(border: GradientBoxBorder(
                            
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                        colors: [borderTop,borderbottom]),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
                                    child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/heroicon.png'),
                                  GradientText2(
                                   text: 'Upload Photo'.tr,
                                    weight: FontWeight.w400,
                                  ),
                                ],
                              ),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: BioInputField(
                              lable: 'Write a Caption'.tr,
                              controller: controller.captionController,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GradientButton(
                              title: 'Post'.tr,
                              onPressed: controller.areFieldsFilled.value
                                  ? () {
                                      controller.createPost();
                                    }
                                  : () {
                                      UiUtilites.errorSnackbar('Fill out all fields'.tr,
                                          'Please fill all above fields'.tr);
                                    },
                              selected: controller.areFieldsFilled.value)
                        ],
                                        ),
                                      ),
                      )),
                ),
        ),
      ):BasicLoader(),
          
    );
  }
}
