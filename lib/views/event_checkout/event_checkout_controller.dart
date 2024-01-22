import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/banner_api.dart';
import 'package:mudarribe_trainer/api/coupon_code_api.dart';
import 'package:mudarribe_trainer/api/event_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/banner_charges.dart';
import 'package:mudarribe_trainer/models/coupon_code.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/event_service.dart';
import 'package:mudarribe_trainer/services/payment_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

import 'package:mudarribe_trainer/views/event_checkout/event_checkout_view.dart';

class EventcheckoutController extends GetxController {
  static EventcheckoutController instance = Get.find();
  final BusyController busyController = Get.find();

  final _eventService = EventService();
  final _paymentService = PaymentService();
  final _couponCodeApi = CouponCodeApi();

  TrainerEvent? event;
  BannerCharges? bannerCharges;

  final _userService = UserService();
  AppUser? currentUser;
  final _eventApi = EventApi();
  final _bannerApi = BannerApi();

  TextEditingController promoCode = TextEditingController();
  int discount = 0;
  bool isCode = false;
  String price = '';
  String total = '';

  PaymentMethod? site;
  toggleplan(PaymentMethod value) {
    site = value;
    update();
  }

  @override
  void onInit() {
    site = PaymentMethod.visa;
    update();
    super.onInit();
  }

  var isButtonPressed = false.obs;

  void payBannerCharges() async {
    bool IsPayment =
        await _paymentService.makePayment(int.parse(bannerCharges!.amount!));

    if (IsPayment) {
      busyController.setBusy(true);
      await _eventApi.updateEventPaymentStatus(event!.id);
      busyController.setBusy(false);
      Get.back();
      Get.back();
      UiUtilites.successAlert(Get.context, 'Done'.tr);
    }
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
    }
    update();
  }

  Future getBannerCharges() async {
    bannerCharges = await _bannerApi.getBannerCharges();
    print(bannerCharges!.amount);
    price = bannerCharges!.amount!;
    update();
  }

  Future getTrainerEvent(id) async {
    busyController.setBusy(true);
    await getAppUser();
    await getBannerCharges();
    event = await _eventService.getTrainerEvent(eventId: id);
    update();
    busyController.setBusy(false);
  }

  void applyPromoCode() async {
    if (promoCode.text.isEmpty) {
      UiUtilites.errorSnackbar('Empty Promo Code', 'Please enter code first'.tr);
      return;
    }
    CouponCode? couponCode = await _couponCodeApi.getCouponCode(promoCode.text);
    if (couponCode != null) {
      discount =
          (int.parse(price) * int.parse(couponCode.percentage) / 100).toInt();
      total = (int.parse(price) - discount).toString();
      isCode = !isCode;
      update();
    } else {
      UiUtilites.errorSnackbar(
          'Invalid Promo Code'.tr, 'Please enter correct code'.tr);
    }
  }
}
