// // ignore_for_file: unused_field

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:mudarribe_trainer/api/auth_api.dart';
// import 'package:mudarribe_trainer/helpers/loading_helper.dart';
// import 'package:mudarribe_trainer/models/app_user.dart';

// import 'package:mudarribe_trainer/services/user_service.dart';

// class OrderController extends GetxController {
//   static OrderController instance = Get.find();
//   final BusyController busyController = Get.find();

//   String? id;

//   RxBool areFieldsFilled = false.obs;
//   final _authApi = AuthApi();

//   AppUser? currentUser;
//   final _userService = UserService();

//   @override
//   void onInit() {
//     getAppUser();

//     super.onInit();
//   }

//   Future getAppUser() async {
//     final User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       currentUser = await _userService.getAuthUser();
//       update();
//     }
//   }
// }

// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/order_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/combine_order.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  final BusyController busyController = Get.find();
  List<CombinedOrderData> orders = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;
  final scrollControllers = ScrollController();

  @override
  void onInit() {
    fetchOrders();
    // markOrdersAsSeen();
    scrollControllers.addListener(scrollListener);
    super.onInit();
  }

  void scrollListener() {
    double maxScroll = scrollControllers.position.maxScrollExtent;
    double currentScroll = scrollControllers.position.pixels;
    double scrollThreshold = maxScroll * 0.8;

    if (currentScroll >= scrollThreshold) {
      print(lastDocument);
      if (lastDocument != null) {
        fetchMoreOrders(lastDocument);
        lastDocument = null;
      }
    }
  }

  void markOrdersAsSeen(id) async {
    try {
      // Update all orders to mark them as seen
      await _firestore.collection('orders').doc(id).update({'seen': true});
      // .where('order', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      // .where('seen', isEqualTo: false)
      // .get();

      // List<DocumentSnapshot<Map<String, dynamic>>> documents =
      //     querySnapshot.docs;

      // for (DocumentSnapshot<Map<String, dynamic>> document in documents) {
      //   await document.reference.update({'seen': true});
      // }
    } catch (e) {
      print('Error marking orders as seen: $e');
    }
  }

  bool busyIndicator = false;
  bool isMoreItemFetching = false;
  // Fetch initial orders
  fetchOrders() async {
    busyIndicator = true;
    update();
    orders = await OrderApi.fetchTrainerOrders(lastDocument: lastDocument);
    if (orders.isNotEmpty) {
      lastDocument = orders.last.lastdoc;
      print(lastDocument);
      isMoreItemFetching = true;
    }
    if (orders.isEmpty) {
      isMoreItemFetching = false;
    }
    print(orders);
    busyIndicator = false;
    update();
  }

  // Fetch more orders
  fetchMoreOrders(DocumentSnapshot? lastdoc) async {
    List<CombinedOrderData> moreOrders =
        await OrderApi.fetchTrainerOrders(lastDocument: lastdoc);
    if (moreOrders.isNotEmpty) {
      lastDocument = moreOrders.last.lastdoc;
      isMoreItemFetching = true;
      update();
    }
    if (moreOrders.isEmpty) {
      isMoreItemFetching = false;
      update();
    }
    orders.addAll(moreOrders);
    update();
  }

  @override
  void onClose() {
    scrollControllers.dispose();
    super.onClose();
  }
}
