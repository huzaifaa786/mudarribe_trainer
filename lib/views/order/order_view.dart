// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                          if (snapshot.hasError) {
                            return Text('');
                          }
                          if (!snapshot.hasData) {
                            return Text('');
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
                                    onTapSendPlan: () {
                                      Get.toNamed(AppRoutes.sendplanhome,
                                          parameters: {
                                            "userId": combinedOrderData[index]
                                                .trainee
                                                .id,
                                            "orderId": combinedOrderData[index]
                                                .order
                                                .id
                                          });
                                    },
                                    onTapMessage: () {
                                      Get.to(
                                        () => ChatPage(
                                          arguments: ChatPageArguments(
                                            peerId: combinedOrderData[index]
                                                .trainee
                                                .id,
                                            peerAvatar: combinedOrderData[index]
                                                        .trainee
                                                        .imageUrl !=
                                                    null
                                                ? combinedOrderData[index]
                                                    .trainee
                                                    .imageUrl!
                                                : 'https://dcblog.b-cdn.net/wp-content/uploads/2021/02/Full-form-of-URL-1.jpg',
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
                                    profileImage: combinedOrderData[index]
                                        .trainee
                                        .imageUrl,
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
