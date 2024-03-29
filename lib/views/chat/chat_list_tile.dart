// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mudarribe_trainer/views/chat/chat_page.dart';

class CustomChatListItem extends StatelessWidget {
  final Map<String, dynamic> userData;

  const CustomChatListItem({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    String time;
    int timestamp = int.parse(userData['time']);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    if (difference.inMinutes < 60) {
      time = '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      time = '${difference.inHours}h ago';
    } else {
      time = dateTime.toString().split(' ')[0];
    }
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 2, right: 2, left: 2),
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Center(
          child: ListTile(
            // tileColor: Colors.grey.withOpacity(0.2),
            leading: userData['profileImageUrl'] == null
                ? SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: Get.isDarkMode
                            ? white
                            : Colors.grey.withOpacity(0.2),
                        child: Icon(Icons.person),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: userData['profileImageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            title: Row(
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.38),
                  child: Text(
                    userData['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                    showBadge: userData['seen'] == true ? false : true,
                  ),
                )
              ],
            ),
            subtitle: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.38),
              child: Text(
                time,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Get.to(
                () => ChatPage(
                  arguments: ChatPageArguments(
                    peerId: userData['id'],
                    peerAvatar: userData['profileImageUrl'] ??
                        'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
                    peerNickname: userData['name'],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
