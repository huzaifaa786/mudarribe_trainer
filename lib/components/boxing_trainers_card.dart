// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class PostCard extends StatelessWidget {
  const PostCard(
      {super.key,
      this.userimg,
      this.username,
      this.postdescription,
      this.postimg,
      this.time,
      this.postId,
      this.save,
      this.onProfileImageTap,
      this.onsaved});
  final userimg;
  final username;
  final onsaved;
  final postdescription;
  final postimg;
  final time;
  final postId;
  final save;
  final onProfileImageTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: TopBar(
            text: "",
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 12, left: 15, right: 15),
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
              color: bgContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: onProfileImageTap,
                            child: Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(colors: const [
                                      borderTop,
                                      borderTop,
                                      borderbottom,
                                      borderbottom
                                    ]),
                                    width: 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(imageUrl: userimg),
                                  // Image.network(userimg),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8,
                            ),
                            child: Text(
                              username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          UiUtilites.confirmStoryAlert(
                              context,
                              "Are you sure that you want to delete this post ?"
                                  .tr, () async {
                            print('object $postId');
                            DocumentReference documentRef =
                                await FirebaseFirestore.instance
                                    .collection('trainer_posts')
                                    .doc(postId);
                            print('$documentRef');
                            Get.back();
                            await documentRef.delete();
                            Get.back();
                          }, () {
                            Get.back();
                          }, "Yes".tr, "No".tr);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(13),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 16,
                  ),
                  child: Container(
                    height: 353,
                    // width: 370,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: postimg,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: bgContainer,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: Get.width * 0.89),
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 18,
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(text: '  '),
                            TextSpan(
                              text: postdescription,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     left: 10,
                //     right: 10,
                //     top: 5,
                //   ),
                //   child: Row(
                //     children: [
                //       Text(
                //         time,
                //         style: TextStyle(
                //           color: Colors.white.withOpacity(0.5),
                //           fontSize: 12,
                //           fontFamily: 'Poppins',
                //           fontWeight: FontWeight.w500,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
