import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';
import 'package:mudarribe_trainer/services/event_service.dart';

import 'package:mudarribe_trainer/services/user_service.dart';

class MyEventController extends GetxController {
  static MyEventController instance = Get.find();

  final _eventService = EventService();

  List<TrainerEvent> events = [];

  final _userService = UserService();
  AppUser? currentUser;

  @override
  void onInit() {
    getAppUser();
    super.onInit();
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
      getTrainerEvents();
    }
    update();
  }

  Future getTrainerEvents() async {
    events = await _eventService.getTrainerEvents(trainerId: currentUser!.id);
   
    update();
  }
}
