import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/app_user_trans.dart';
import 'package:mudarribe_trainer/services/user_service.dart';

class HomeContoller extends GetxController {
  static HomeContoller instance = Get.find();
  final BusyController busyController = Get.find();
  final _userService = UserService();
  AppUserTransalted? currentUser;
  int chatLength = 0;
  int orderCount = 0;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _chatListener;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _orderListener;

  @override
  void onInit() {
    getAppUser();
    listenToChats();
    listenToOrders();
    super.onInit();
  }

  @override
  void onClose() {
    _chatListener.cancel();
    _orderListener.cancel();
    super.onClose();
  }

  listenToChats() {
    _chatListener = FirebaseFirestore.instance
        .collection('messages')
        .where('trainerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('trainerSeen', isEqualTo: false)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      chatLength = snapshot.docs.length;
      print('Number of chats: $chatLength');
      update();
    });
  }

  listenToOrders() {
    _orderListener = FirebaseFirestore.instance
        .collection('orders')
        .where('trainerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('seen', isEqualTo: false)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      orderCount = snapshot.docs.length;
      print('Number of unseen orders: $orderCount');
      update();
    });
  }

  Future<void> getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser1();
    }
    update();
  }

  //   userlogout() {
  // logout();

  //   }
}
