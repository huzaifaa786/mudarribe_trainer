// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/ordercard.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/chat/chat_page.dart';
import 'package:mudarribe_trainer/views/order/order_controllers.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
                body: SingleChildScrollView(
                  controller: controller.scrollControllers,
                  child: SafeArea(
                    child: Directionality(
                      textDirection: box.read('locale') == 'ar'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.orders.length,
                              itemBuilder: (context, index) {
                                return OrderCard(
                                  onTapSendPlan: controller
                                              .orders[index].order.type !=
                                          'My_Plan'
                                      ? () {
                                          if (controller.orders[index].package!
                                                      .category! ==
                                                  'nutrition' ||
                                              controller.orders[index].package!
                                                      .category! ==
                                                  'excercise') {
                                            Get.toNamed(AppRoutes.exercise,
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
                                                      .orders[index].trainee.id,
                                                  "orderId": controller
                                                      .orders[index].order.id,
                                                  'trainerName': controller
                                                      .orders[index]
                                                      .trainer
                                                      .name
                                                      .toString(),
                                                });
                                          } else {
                                            Get.toNamed(AppRoutes.sendplanhome,
                                                parameters: {
                                                  "userId": controller
                                                      .orders[index].trainee.id,
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
                                                      .orders[index].order.id
                                                });
                                          }
                                        }
                                      : () {
                                          Get.toNamed(AppRoutes.exercise,
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
                                                    .orders[index].trainee.id,
                                                "orderId": controller
                                                    .orders[index].order.id,
                                                'trainerName': controller
                                                    .orders[index].trainer.name
                                                    .toString(),
                                              });
                                        },
                                  onTapMessage: () {
                                    Get.to(
                                      () => ChatPage(
                                        arguments: ChatPageArguments(
                                          peerId: controller
                                              .orders[index].trainee.id,
                                          peerAvatar:
                                              'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
                                          peerNickname: controller
                                              .orders[index].trainee.name!,
                                        ),
                                      ),
                                    );
                                  },
                                  userName:
                                      controller.orders[index].trainee.name,
                                  packageName: controller
                                              .orders[index].order.type ==
                                          'My_Plan'
                                      ? controller
                                          .orders[index].personalPlan!.name
                                      : controller.orders[index].package!.name,
                                  duration:
                                      controller.orders[index].order.type ==
                                              'My_Plan'
                                          ? controller.orders[index]
                                              .personalPlan!.duration
                                          : controller
                                              .orders[index].package!.duration,
                                  price: controller.orders[index].order.type ==
                                          'My_Plan'
                                      ? controller
                                          .orders[index].personalPlan!.price
                                      : controller.orders[index].package!.price,
                                );
                              },
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
                  ),
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}
