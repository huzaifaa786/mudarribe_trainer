// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudarribe_trainer/api/event_api.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/event_card.dart';
import 'package:mudarribe_trainer/components/ordercard.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/models/event_data_combined.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/time.dart';
import 'package:mudarribe_trainer/views/chat/chat_page.dart';
import 'package:mudarribe_trainer/views/event/myevent_controller.dart';
import 'package:mudarribe_trainer/views/order/order_controllers.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final myEvent = MyEventController();
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) => controller.busyIndicator == false
          ? Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  forceMaterialTransparency: true,
                  title: TitleTopBar(
                    name: 'Orders'.tr,
                    ontap: () {
                      Get.back();
                    },
                  ),
                ),
                body: SafeArea(
                  child: Directionality(
                    textDirection: box.read('locale') == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: borderTop,
                            indicatorWeight: 4,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Packages'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Events'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                SingleChildScrollView(
                                  controller: controller.scrollControllers,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: controller.orders.isNotEmpty
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount:
                                                    controller.orders.length,
                                                itemBuilder: (context, index) {
                                                  return OrderCard(
                                                    id: controller
                                                        .orders[index].order.id,
                                                    sent: controller
                                                        .orders[index].sent,
                                                    expire: hideAndShowButtonOnTime(
                                                        controller.orders[index]
                                                            .order.id,
                                                        controller
                                                                    .orders[
                                                                        index]
                                                                    .order
                                                                    .type !=
                                                                'My_Plan'
                                                            ? controller
                                                                .orders[index]
                                                                .package!
                                                                .duration!
                                                            : controller
                                                                .orders[index]
                                                                .personalPlan!
                                                                .duration!),
                                                    fromDate: timeConverstion(
                                                        controller.orders[index]
                                                            .order.id),
                                                    toDate: calculateNewDate(
                                                        controller.orders[index]
                                                            .order.id,
                                                        controller
                                                                    .orders[
                                                                        index]
                                                                    .order
                                                                    .type !=
                                                                'My_Plan'
                                                            ? controller
                                                                .orders[index]
                                                                .package!
                                                                .duration!
                                                            : controller
                                                                .orders[index]
                                                                .personalPlan!
                                                                .duration!),
                                                    seen: controller
                                                        .orders[index]
                                                        .order
                                                        .seen,
                                                    profileImage: controller
                                                        .orders[index]
                                                        .trainee
                                                        .imageUrl,
                                                    onTapSendPlan:
                                                        controller
                                                                    .orders[
                                                                        index]
                                                                    .order
                                                                    .type !=
                                                                'My_Plan'
                                                            ? () {
                                                                controller.markOrdersAsSeen(
                                                                    controller
                                                                        .orders[
                                                                            index]
                                                                        .order
                                                                        .id);
                                                                if (controller
                                                                            .orders[
                                                                                index]
                                                                            .package!
                                                                            .category! ==
                                                                        'nutrition' ||
                                                                    controller
                                                                            .orders[index]
                                                                            .package!
                                                                            .category! ==
                                                                        'excercise') {
                                                                  Get.toNamed(
                                                                          AppRoutes
                                                                              .exercise,
                                                                          parameters: {
                                                                        'firebaseToken': controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .firebaseToken!,
                                                                        "category": controller
                                                                            .orders[index]
                                                                            .package!
                                                                            .category!,
                                                                        "userId": controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .id,
                                                                        "orderId": controller
                                                                            .orders[index]
                                                                            .order
                                                                            .id,
                                                                        'trainerName': controller
                                                                            .orders[index]
                                                                            .trainer
                                                                            .name
                                                                            .toString(),
                                                                      })!
                                                                      .then(
                                                                          (value) {
                                                                    controller
                                                                            .lastDocument =
                                                                        null;
                                                                    controller
                                                                        .orders = [];
                                                                    controller
                                                                        .fetchOrders();
                                                                  });
                                                                } else {
                                                                  Get.toNamed(
                                                                          AppRoutes
                                                                              .sendplanhome,
                                                                          parameters: {
                                                                        "userId": controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .id,
                                                                        "firebaseToken": controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .firebaseToken
                                                                            .toString(),
                                                                        "trainerName": controller
                                                                            .orders[index]
                                                                            .trainer
                                                                            .name
                                                                            .toString(),
                                                                        "orderId": controller
                                                                            .orders[index]
                                                                            .order
                                                                            .id
                                                                      })!
                                                                      .then(
                                                                          (value) {
                                                                    controller
                                                                            .lastDocument =
                                                                        null;
                                                                    controller
                                                                        .orders = [];
                                                                    controller
                                                                            .lastDocument =
                                                                        null;
                                                                    controller
                                                                        .fetchOrders();
                                                                  });
                                                                }
                                                              }
                                                            : () {
                                                                if (controller
                                                                            .orders[
                                                                                index]
                                                                            .personalPlan!
                                                                            .category! ==
                                                                        'nutrition' ||
                                                                    controller
                                                                            .orders[index]
                                                                            .personalPlan!
                                                                            .category! ==
                                                                        'excercise') {
                                                                  controller.markOrdersAsSeen(
                                                                      controller
                                                                          .orders[
                                                                              index]
                                                                          .order
                                                                          .id);
                                                                  Get.toNamed(
                                                                          AppRoutes
                                                                              .exercise,
                                                                          parameters: {
                                                                        'firebaseToken': controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .firebaseToken!,
                                                                        "category": controller
                                                                            .orders[index]
                                                                            .personalPlan!
                                                                            .category!,
                                                                        "userId": controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .id,
                                                                        "orderId": controller
                                                                            .orders[index]
                                                                            .order
                                                                            .id,
                                                                        'trainerName': controller
                                                                            .orders[index]
                                                                            .trainer
                                                                            .name
                                                                            .toString(),
                                                                      })!
                                                                      .then(
                                                                          (value) {
                                                                    controller
                                                                            .lastDocument =
                                                                        null;
                                                                    controller
                                                                        .orders = [];
                                                                    controller
                                                                        .fetchOrders();
                                                                  });
                                                                } else {
                                                                  Get.toNamed(
                                                                          AppRoutes
                                                                              .sendplanhome,
                                                                          parameters: {
                                                                        "userId": controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .id,
                                                                        "firebaseToken": controller
                                                                            .orders[index]
                                                                            .trainee
                                                                            .firebaseToken
                                                                            .toString(),
                                                                        "trainerName": controller
                                                                            .orders[index]
                                                                            .trainer
                                                                            .name
                                                                            .toString(),
                                                                        "orderId": controller
                                                                            .orders[index]
                                                                            .order
                                                                            .id
                                                                      })!
                                                                      .then(
                                                                          (value) {
                                                                    controller
                                                                            .lastDocument =
                                                                        null;
                                                                    controller
                                                                        .orders = [];
                                                                    controller
                                                                            .lastDocument =
                                                                        null;
                                                                    controller
                                                                        .fetchOrders();
                                                                  });
                                                                }
                                                              },
                                                    onTapMessage: () {
                                                      Get.to(
                                                        () => ChatPage(
                                                          arguments:
                                                              ChatPageArguments(
                                                            peerId: controller
                                                                .orders[index]
                                                                .trainee
                                                                .id,
                                                            peerAvatar: controller
                                                                        .orders[
                                                                            index]
                                                                        .trainee
                                                                        .imageUrl !=
                                                                    ''
                                                                ? controller
                                                                    .orders[
                                                                        index]
                                                                    .trainee
                                                                    .imageUrl!
                                                                : 'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
                                                            peerNickname:
                                                                controller
                                                                    .orders[
                                                                        index]
                                                                    .trainee
                                                                    .name!,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    userName: controller
                                                        .orders[index].trainee.name,
                                                    packageName: controller
                                                                .orders[index]
                                                                .order
                                                                .type ==
                                                            'My_Plan'
                                                        ? controller
                                                            .orders[index]
                                                            .personalPlan!
                                                            .name
                                                        : controller
                                                            .orders[index]
                                                            .package!
                                                            .name,
                                                    duration: controller
                                                                .orders[index]
                                                                .order
                                                                .type ==
                                                            'My_Plan'
                                                        ? controller
                                                            .orders[index]
                                                            .personalPlan!
                                                            .duration
                                                        : controller
                                                            .orders[index]
                                                            .package!
                                                            .duration,
                                                    price: controller
                                                                .orders[index]
                                                                .order
                                                                .type ==
                                                            'My_Plan'
                                                        ? controller
                                                            .orders[index]
                                                            .personalPlan!
                                                            .price
                                                        : controller
                                                            .orders[index]
                                                            .package!
                                                            .price,
                                                  );
                                                },
                                              )
                                            : SizedBox(
                                                height: Get.height * 0.8,
                                                child: Center(
                                                  child: Text(
                                                      'No Order Found !'.tr),
                                                ),
                                              ),
                                      ),
                                      controller.isMoreItemFetching == true
                                          ? SizedBox(
                                              height: 50,
                                              child: CupertinoActivityIndicator(
                                                  color: borderTop))
                                          : SizedBox(height: 20)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: FutureBuilder<List<CombinedEventData>>(
                                    future: EventApi
                                        .fetchCombinedTrainerNotifications(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        );
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Center(
                                          child: Text('No Order Found !'.tr),
                                        );
                                      } else {
                                        return ListView.builder(
                                          // shrinkWrap: true,
                                          // physics: BouncingScrollPhysics(),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            var combineEvent =
                                                snapshot.data![index];
                                            return EventCard(
                                              profileImage:
                                                  combineEvent.trainee.imageUrl,
                                              onTapMessage: () {
                                                         controller.markEventAsSeen(
                                                    combineEvent.event_order.id);
                                                Get.to(
                                                  () => ChatPage(
                                                    arguments:
                                                        ChatPageArguments(
                                                      peerId: combineEvent
                                                          .trainee.id,
                                                      peerAvatar: combineEvent
                                                                  .trainee
                                                                  .imageUrl !=
                                                              ''
                                                          ? combineEvent
                                                              .trainee.imageUrl!
                                                          : 'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
                                                      peerNickname: combineEvent
                                                          .trainee.name!,
                                                    ),
                                                  ),
                                                );
                                              },
                                              userName:
                                                  combineEvent.trainee.name,
                                              eventName:
                                                  combineEvent.event.title,
                                              duration: combineEvent.event.date,
                                              expdate: combineEvent.event.todate,
                                              price: combineEvent
                                                  .event_order.amount
                                                  .toString(),
                                              seen: combineEvent.event_order.seen,
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}

class FirebaseFirestore {}
