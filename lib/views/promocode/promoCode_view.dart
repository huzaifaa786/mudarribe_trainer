// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/api/promocode.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/title_topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/promocode/promoCode_controller.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:mudarribe_trainer/models/promo_code.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({Key? key}) : super(key: key);
  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromoCodeContoller>(
      builder: (controller) => controller.currentUser != null
          ? BusyIndicator(
              child: Scaffold(
                appBar: AppBar(
                  forceMaterialTransparency: true,
                  automaticallyImplyLeading: false,
                  title: TitleTopBar(
                    name: '',
                    ontap: () {
                      Get.back();
                    },
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 40, bottom: 50, left: 25, right: 15),
                                child: Text(
                                  'My Promo code',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                ).translate(),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              // height: 300,
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 40, bottom: 70),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 15, 15, 15),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputField(
                                    lable: 'Promo name',
                                    controller: controller.nameController,
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  InputField(
                                    lable: 'Discount percentage',
                                    controller: controller.percentagecontroller,
                                    type: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     SvgPicture.asset('assets/images/Vector (1).svg'),
                          //     SizedBox(
                          //       width: 5,
                          //     ),
                          //     Text('Promo Code Added Successfully'),
                          //   ],
                          // ),
                          FirestorePagination(
                            shrinkWrap: true,
                            isLive: true,
                            limit: 6,
                            onEmpty: Text(''),
                            viewType: ViewType.list,
                            physics: BouncingScrollPhysics(),
                            query: PromoCodeApi.promoCodes,
                            bottomLoader:
                                Center(child: CircularProgressIndicator()),
                            itemBuilder: (context, documentSnapshot, index) {
                              final promoCodeData = documentSnapshot.data()
                                  as Map<String, dynamic>;
                              final promoCode =
                                  PromoCodeModal.fromMap(promoCodeData);
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 12),
                                child: ListTile(
                                  tileColor: bgContainer,
                                  title: Text(
                                      'Promo Code: ${promoCode.promoCodeName}'),
                                  subtitle: Text(
                                      'Description: ${promoCode.promoCodeDiscount}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('promocodes')
                                              .where('id',
                                                  isEqualTo:
                                                      promoCode.promoCodeId)
                                              .get()
                                              .then((QuerySnapshot snapshot) {
                                            snapshot.docs.forEach(
                                                (DocumentSnapshot doc) {
                                              doc.reference.delete();
                                              UiUtilites.successSnackbar(
                                                  'Promo Code deleted successfully!',
                                                  '');
                                            });
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon:
                                            Icon(Icons.edit, color: borderTop),
                                        onPressed: () {
                                          controller.nameController.text =
                                              promoCode.promoCodeName;
                                          controller.percentagecontroller.text =
                                              promoCode.promoCodeDiscount;
                                          controller.id = promoCode.promoCodeId;
                                          controller.edit = true;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              // return PromoCodeCard(
                              //   promoCodeDiscount: promoCode.promoCodeDiscount,
                              //   promoCodeName: promoCode.promoCodeName,
                              //   promoCodeId: promoCode.promoCodeId,
                              // );
                            },
                          ),
                          // SizedBox(
                          //   height: 150,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GradientButton(
                    title: !controller.edit ? 'Save Changes' : 'Edit Changes',
                    onPressed: controller.areFieldsFilled.value
                        ? () {
                            !controller.edit
                                ? controller.storePromocode()
                                : controller.updatePromocode();
                          }
                        : () {
                            UiUtilites.errorSnackbar('Fill out all fields',
                                'Please fill all above fields');
                          },
                    selected: controller.areFieldsFilled.value,
                  ),
                ),
              ),
            )
          : BasicLoader(),
    );
  }
}
