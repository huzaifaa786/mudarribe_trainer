import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/banner_api.dart';
import 'package:mudarribe_trainer/api/event_api.dart';
import 'package:mudarribe_trainer/api/event_storage_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/banner_charges.dart';
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

  TrainerEvent? event;
  BannerCharges? bannerCharges;

  final _userService = UserService();
  AppUser? currentUser;
  final _eventApi = EventApi();
  final _bannerApi = BannerApi();

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
      UiUtilites.successAlert(Get.context, 'Done');
      Get.offNamed(AppRoutes.myevent);
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
}
