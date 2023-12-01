import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/event_storage_api.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';
import 'package:mudarribe_trainer/services/event_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class AddEventContoller extends GetxController {
  static AddEventContoller instance = Get.find();
  final _imageSelectorApi = ImageSelectorApi();
  final _eventStorageApi = EventStorageApi();
  final _userService = UserService();
  final _eventService = EventService();
  int selectedOption = 1;
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  String address = '';
  // listners

  RxBool areFieldsFilled = false.obs;
  AppUser? currentUser;

  // documents
  File? eventImage;
  @override
  void onInit() {
    super.onInit();
    getAppUser();
    eventTitleController.addListener(() {
      checkFields();
    });
    endTimeController.addListener(() {
      checkFields();
    });
    dateController.addListener(() {
      checkFields();
    });
    startTimeController.addListener(() {
      checkFields();
    });
    priceController.addListener(() {
      checkFields();
    });
    capacityController.addListener(() {
      checkFields();
    });
  }

  void value(value) {
    selectedOption = value!;
    update();
  }

  void checkFields() {
    if (eventTitleController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        startTimeController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        capacityController.text.isNotEmpty &&
        eventImage != null &&
        address != '') {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  Future getAppUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUser = await _userService.getAuthUser();
    }
    update();
  }

  Future selectEventImage() async {
    final tempImage = await _imageSelectorApi.selectImage();
    eventImage = tempImage;
    checkFields();
    update();
  }

  Future _saveEventImage(eventId) async {
    if (eventImage != null) {
      final CloudStorageResult storageResult = await _eventStorageApi
          .uploadEventImage(eventId: eventId, imageToUpload: eventImage!);
      return storageResult;
    }
  }

  Future addEvent() async {
    final eventId = DateTime.now().millisecondsSinceEpoch.toString();
    CloudStorageResult? imageResult = await _saveEventImage(eventId);
    if (imageResult!.imageUrl != '') {
      await _eventService.createEvent(
          event: TrainerEvent(
              id: eventId,
              title: eventTitleController.text,
              price: priceController.text,
              date: dateController.text,
              startTime: startTimeController.text,
              endTime: endTimeController.text,
              trainerId: currentUser!.id,
              capacity: capacityController.text,
              address: address,
              eventType: selectedOption == 1 ? EventType.paid : EventType.free,
              paymentStatus: PaymentStatus.pending,eventStatus: EventStatus.open));
      clearValues();
      UiUtilites.successAlert(Get.context, 'Event Shared Successfully');
    }
  }

  clearValues() {
    eventTitleController.clear();
    priceController.clear();
    dateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    capacityController.clear();
    selectedOption = 1;
    address = '';
    eventImage = null;
    areFieldsFilled.value = false;
  }
}
