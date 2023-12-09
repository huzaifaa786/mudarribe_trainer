import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/event_api.dart';
import 'package:mudarribe_trainer/api/event_storage_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';
import 'package:mudarribe_trainer/services/event_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class MyEventController extends GetxController {
  static MyEventController instance = Get.find();
  final BusyController busyController = Get.find();

  final _eventService = EventService();

  List<TrainerEvent> events = [];

  final _userService = UserService();
  AppUser? currentUser;
  final _eventApi = EventApi();
  final _eventStorageApi = EventStorageApi();

  @override
  void onInit() {
    getAppUser();
    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
      await getTrainerEvents();
    }
    update();
  }

  Future getTrainerEvents() async {
    busyController.setBusy(true);

    events = await _eventService.getTrainerEvents(trainerId: currentUser!.id);

    update();
    busyController.setBusy(false);
  }

  Future deleteEvent(TrainerEvent event) async {
    bool isDeleted = await _eventApi.deleteEvent(event.id);
    _eventStorageApi.deleteEventImage(event.id, event.imageFileName!);
    getTrainerEvents();
    Get.back();
    UiUtilites.successAlert(Get.context, 'Event Deleted Successfully');
  }

  Future closeEvent(TrainerEvent event) async {
    await _eventApi.closeEvent(event.id);
    getTrainerEvents();
    Get.back();
    UiUtilites.successAlert(Get.context, 'Event Closed Successfully');
  }
}
