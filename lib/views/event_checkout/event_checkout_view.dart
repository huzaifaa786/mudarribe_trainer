// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/Eventcheckoutcontainer.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/views/event_checkout/event_checkout_controller.dart';
import 'package:provider/provider.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

class EventcheckoutView extends StatefulWidget {
  const EventcheckoutView({super.key});

  @override
  State<EventcheckoutView> createState() => _EventcheckoutViewState();
}

enum PaymentMethod { visa, googlePay, applePay }

class _EventcheckoutViewState extends State<EventcheckoutView> {
  @override
  Widget build(BuildContext context) {
    String id = Get.arguments;
    GetStorage box = GetStorage();
    return GetBuilder<EventcheckoutController>(
      initState: (state) {
        Future.delayed(Duration(milliseconds: 100), () {
          state.controller!.getTrainerEvent(id);
        });
      },
      builder: (controller) => controller.event != null
          ? Directionality(
            textDirection: TextDirection.ltr,
            child: BusyIndicator(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Get.isDarkMode ? Colors.black: white,
                    leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color:  Get.isDarkMode? white: maincolor ,
                      ),
                    ),
                    title: Text(
                      'Event Check out'.tr,
                      style: TextStyle(
                          fontSize: 20,
                          color:  Get.isDarkMode? white: maincolor ,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  body: Directionality(
                    textDirection: box.read('locale') == 'ar'? TextDirection.rtl: TextDirection.ltr,
                    child: SafeArea(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                EventcheckoutContainer(
                                    userName: controller.currentUser!.name,
                                    userImage:
                                        controller.currentUser!.profileImageUrl,
                                    userBio: controller.currentUser!.categories!
                                        .join('& '),
                                    eventDate: controller.event!.date,
                                    bannerPrice: controller.bannerCharges!.amount),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 67,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                       color:  Get.isDarkMode? bgContainer: Colors.grey.withOpacity(0.2) ,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Promo Code'.tr,
                                            style: TextStyle(
                                               color:  Get.isDarkMode? white: maincolor ,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          controller.total != ''
                                              ? GradientText2(
                                                  text: controller.promoCode.text,
                                                  size: 16,
                                                  weight: FontWeight.w700,
                                                )
                                              : controller.isCode
                                                  ? Row(
                                                      children: [
                                                        Container(
                                                            height: 35,
                                                            width: 110,
                                                            padding:
                                                                EdgeInsets.all(2),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .grey),
                                                            child: TextField(
                                                              controller: controller
                                                                  .promoCode,
                                                              style: TextStyle(
                                                                  color:
                                                                      Colors.black),
                                                              decoration:
                                                                  InputDecoration(
                                                                      border:
                                                                          InputBorder
                                                                              .none,
                                                                      fillColor:
                                                                          Colors
                                                                              .grey,
                                                                      focusColor:
                                                                          Colors
                                                                              .grey),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .applyPromoCode();
                                                            },
                                                            child: GradientText2(
                                                              text: 'Apply'.tr,
                                                              size: 16.0,
                                                              weight:
                                                                  FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        controller.isCode = true;
                                                        setState(() {});
                                                      },
                                                      child: GradientText2(
                                                        text: 'Add Code'.tr,
                                                        size: 16.0,
                                                        weight: FontWeight.w700,
                                                      ),
                                                    )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, left: 5, bottom: 20),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Summary'.tr,
                                      style: TextStyle(
                                         color:  Get.isDarkMode? white: maincolor ,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 216,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color:  Get.isDarkMode? bgContainer: Colors.grey.withOpacity(0.2) ,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Price'.tr,
                                              style: TextStyle(
                                                 color:  Get.isDarkMode? white: maincolor ,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              controller.bannerCharges!.amount! +
                                                  ' AED'.tr,
                                              style: TextStyle(
                                                 color:  Get.isDarkMode? white: maincolor ,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Divider(
                                          thickness: 1,
                                           color:  Get.isDarkMode? dividercolor: white ,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Offer'.tr,
                                              style: TextStyle(
                                                color:  Get.isDarkMode? white: maincolor ,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '${controller.discount} ' + ' AED'.tr,
                                              style: TextStyle(
                                                 color:  Get.isDarkMode? white: maincolor ,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Divider(
                                          thickness: 1,
                                           color:  Get.isDarkMode? dividercolor: white ,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total '.tr,
                                              style: TextStyle(
                                                 color:  Get.isDarkMode? white: maincolor ,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              controller.total == ''
                                                  ? controller.price + ' AED'.tr
                                                  : controller.total + ' AED'.tr,
                                              style: new TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..shader = LinearGradient(
                                                      colors: <Color>[
                                                        borderTop,
                                                        borderTop,
                                                        borderTop,
                                                        borderbottom
                                                      ],
                                                    ).createShader(Rect.fromLTWH(
                                                        0.0, 0.0, 250.0, 70.0))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       top: 35, left: 5, bottom: 20),
                                //   child: Align(
                                //     alignment: Alignment.topLeft,
                                //     child: Text(
                                //       'Payment Method',
                                //       style: TextStyle(
                                //         color: white,
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.w700,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Container(
                                //   height: 282,
                                //   width: MediaQuery.of(context).size.width,
                                //   decoration: BoxDecoration(
                                //     color: bgContainer,
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                //   child: Padding(
                                //     padding:
                                //         const EdgeInsets.only(left: 15, right: 15),
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         Container(
                                //           // height: 58,
                                //           width: MediaQuery.of(context).size.width,
                                //           decoration: BoxDecoration(
                                //               color: Colors.black,
                                //               borderRadius: BorderRadius.circular(24),
                                //               border: Border.all(
                                //                 color: controller.site ==
                                //                         PaymentMethod.visa
                                //                     ? Colors.white
                                //                     : dividercolor,
                                //               )),
                                //           child: Checkedbox(
                                //             staticimage: 'assets/images/visa.png',
                                //             groupvalue: controller.site,
                                //             value: PaymentMethod.visa,
                                //             onchaged: () async {
                                //               await controller
                                //                   .toggleplan(PaymentMethod.visa);
                                //             },
                                //           ),
                                //         ),
                                //         Padding(
                                //           padding: const EdgeInsets.only(
                                //               top: 15, bottom: 15),
                                //           child: Container(
                                //             // height: 58,
                                //             width: MediaQuery.of(context).size.width,
                                //             decoration: BoxDecoration(
                                //                 color: Colors.black,
                                //                 borderRadius:
                                //                     BorderRadius.circular(24),
                                //                 border: Border.all(
                                //                   color: controller.site ==
                                //                           PaymentMethod.applePay
                                //                       ? Colors.white
                                //                       : dividercolor,
                                //                 )),
                                //             child: Checkedbox(
                                //               staticimage:
                                //                   'assets/images/applepay.png',
                                //               groupvalue: controller.site,
                                //               value: PaymentMethod.applePay,
                                //               onchaged: () async {
                                //                 await controller.toggleplan(
                                //                     PaymentMethod.applePay);
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //         Container(
                                //           // height: 58,
                                //           width: MediaQuery.of(context).size.width,
                                //           decoration: BoxDecoration(
                                //               color: Colors.black,
                                //               borderRadius: BorderRadius.circular(24),
                                //               border: Border.all(
                                //                 color: controller.site ==
                                //                         PaymentMethod.googlePay
                                //                     ? white
                                //                     : dividercolor,
                                //               )),
                                //           child: Checkedbox(
                                //             staticimage:
                                //                 'assets/images/googlepay.png',
                                //             groupvalue: controller.site,
                                //             value: PaymentMethod.googlePay,
                                //             onchaged: () async {
                                //               await controller.toggleplan(
                                //                   PaymentMethod.googlePay);
                                //             },
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 30, top: 30, left: 20, right: 20),
                    child: Obx(
                      () => GestureDetector(
                          onTap: () {
                            controller.payBannerCharges();
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 17),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment(1.00, -0.03),
                                  end: Alignment(-1, 0.03),
                                  colors: controller.isButtonPressed.value
                                      ? [bgContainer, bgContainer]
                                      : [Color(0xFF58E0FF), Color(0xFF727DCD)],
                                )),
                            child: Text(
                              'Check Out'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
          )
          : BasicLoader(),
    );
  }
}
