// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/views/chat/chat_list_tile.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          // child: CustomMaterialIndicator(
          // onRefresh: () async {
          //   setState(() {});
          //   Future.delayed(Duration(milliseconds: 1500));
          // },
          // indicatorBuilder: (context, controller) {
          //   return CupertinoActivityIndicator();
          // },
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleTopBar(
                  ontap: () {
                    Get.back();
                  },
                  name: 'Chats'.tr,
                ),
                Flexible(
                  child: FirestorePagination(
                    limit: 6,
                    isLive: true,
                    viewType: ViewType.list,
                    bottomLoader: BasicLoader(),
                    query: FirebaseFirestore.instance
                        .collection('messages')
                        .where('trainerId',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .orderBy('timestamp', descending: true),
                    itemBuilder: (context, documentSnapshot, index) {
                      final userData =
                          documentSnapshot.data() as Map<String, dynamic>;
                      return FutureBuilder<List<Map<String, dynamic>>>(
                        future: fetchUserData(userData),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return SizedBox();
                          } else {
                            final userWithData = snapshot.data!.first;
                            return CustomChatListItem(userData: userWithData);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchUserData(
      Map<String, dynamic> userData) async {
    final userId = userData['userId'];
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      final userMap = userSnapshot.data() as Map<String, dynamic>;
      userMap['seen'] = userData['trainerSeen'];
      userMap['time'] = userData['timestamp'];
      return [userMap];
    } else {
      return [];
    }
  }
}
