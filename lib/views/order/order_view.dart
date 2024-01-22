// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/api/order_api.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/ordercard.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/models/combine_order.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/views/chat/chat_page.dart';
import 'package:mudarribe_trainer/views/order/order_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) => controller.currentUser != null
          ? BusyIndicator(
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  forceMaterialTransparency: true,
                  title: TitleTopBar(
                    name: 'Orders',
                    ontap: () {
                      Get.back();
                    },
                  ),
                ),
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: FutureBuilder<List<CombinedOrderData>>(
                        future: OrderApi.fetchTrainerOrders(),
                        builder: (context, snapshot) {
                          print(snapshot);
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: Get.height * 0.7,
                              child: BasicLoader(
                                background: false,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text('');
                          }
                          if (!snapshot.hasData) {
                            return SizedBox(
                                width: Get.width,
                                height: Get.height,
                                child: Center(
                                    child:
                                        Text('No order found!') ));
                          }
                          List<CombinedOrderData> combinedOrderData =
                              snapshot.data!;
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.9,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: combinedOrderData.length,
                                itemBuilder: (context, index) {
                                  return OrderCard(
                                    onTapSendPlan: combinedOrderData[index]
                                                .order
                                                .type !=
                                            'My_Plan'
                                        ? () {
                                            if (combinedOrderData[index]
                                                        .package!
                                                        .category! ==
                                                    'nutrition' ||
                                                combinedOrderData[index]
                                                        .package!
                                                        .category! ==
                                                    'excercise') {
                                              Get.toNamed(AppRoutes.exercise,
                                                  parameters: {
                                                    'firebaseToken':
                                                        combinedOrderData[index]
                                                            .trainee
                                                            .firebaseToken!,
                                                    "category":
                                                        combinedOrderData[index]
                                                            .package!
                                                            .category!,
                                                    "userId":
                                                        combinedOrderData[index]
                                                            .trainee
                                                            .id,
                                                    "orderId":
                                                        combinedOrderData[index]
                                                            .order
                                                            .id,
                                                    'trainerName':
                                                        combinedOrderData[index]
                                                            .trainer
                                                            .name
                                                            .toString(),
                                                  });
                                            } else {
                                              Get.toNamed(
                                                  AppRoutes.sendplanhome,
                                                  parameters: {
                                                    "userId":
                                                        combinedOrderData[index]
                                                            .trainee
                                                            .id,
                                                    "firebaseToken":
                                                        combinedOrderData[index]
                                                            .trainee
                                                            .firebaseToken
                                                            .toString(),
                                                    "trainerName":
                                                        combinedOrderData[index]
                                                            .trainer
                                                            .name
                                                            .toString(),
                                                    "orderId":
                                                        combinedOrderData[index]
                                                            .order
                                                            .id
                                                  });
                                            }
                                          }
                                        : () {
                                            Get.toNamed(AppRoutes.exercise,
                                                parameters: {
                                                  'firebaseToken':
                                                      combinedOrderData[index]
                                                          .trainee
                                                          .firebaseToken!,
                                                  "category":
                                                      combinedOrderData[index]
                                                          .personalPlan!
                                                          .category!,
                                                  "userId":
                                                      combinedOrderData[index]
                                                          .trainee
                                                          .id,
                                                  "orderId":
                                                      combinedOrderData[index]
                                                          .order
                                                          .id,
                                                  'trainerName':
                                                      combinedOrderData[index]
                                                          .trainer
                                                          .name
                                                          .toString(),
                                                });
                                          },
                                    onTapMessage: () {
                                      Get.to(
                                        () => ChatPage(
                                          arguments: ChatPageArguments(
                                            peerId: combinedOrderData[index]
                                                .trainee
                                                .id,
                                            peerAvatar:
                                                'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
                                            peerNickname:
                                                combinedOrderData[index]
                                                    .trainee
                                                    .name!,
                                          ),
                                        ),
                                      );
                                    },
                                    userName:
                                        combinedOrderData[index].trainee.name,
                                    packageName:
                                        combinedOrderData[index].order.type ==
                                                'My_Plan'
                                            ? combinedOrderData[index]
                                                .personalPlan!
                                                .name
                                            : combinedOrderData[index]
                                                .package!
                                                .name,
                                    price:
                                        combinedOrderData[index].order.type ==
                                                'My_Plan'
                                            ? combinedOrderData[index]
                                                .personalPlan!
                                                .price
                                            : combinedOrderData[index]
                                                .package!
                                                .price,
                                  );
                                }),
                          );
                        }),
                  ),
                )),
              ),
            )
          : BasicLoader(),
    );
  }
}
