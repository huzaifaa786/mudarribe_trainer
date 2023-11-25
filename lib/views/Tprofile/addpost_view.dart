// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/button.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/Tprofile/addpost_controller.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostController>(
      builder: (controller) => controller.currentUser != null
          ? Scaffold(
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 23,
                        ),
                        Text(
                          'New Post',
                          style: TextStyle(
                              color: White,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
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
                            ? Image.file(
                                controller.postImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/newpost.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    BioInputField(
                      lable: 'Write a caption',
                      controller: controller.captionController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                        title: 'Post',
                        onPressed: controller.areFieldsFilled.value
                            ? () {
                                controller.createPost();
                              }
                            : () {
                                UiUtilites.errorSnackbar('Fill out all fields',
                                    'Please fill all above fields');
                              },
                        selected: controller.areFieldsFilled.value)
                  ],
                ),
              )),
            )
          : BasicLoader(),
    );
  }
}
