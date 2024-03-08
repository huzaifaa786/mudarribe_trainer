import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mudarribe_trainer/api/event_storage_api.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/services/event_service.dart';
import 'package:mudarribe_trainer/services/user_service.dart';
import 'package:mudarribe_trainer/values/cropper.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class AddEventContoller extends GetxController {
  static AddEventContoller instance = Get.find();
  final BusyController busyController = Get.find();
  final _imageSelectorApi = ImageSelectorApi();
  final _eventStorageApi = EventStorageApi();
  final _userService = UserService();
  final _eventService = EventService();
  int selectedOption = 1;
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController todateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  String address = '';
  final formKey = GlobalKey<FormState>();

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
    todateController.addListener(() {
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
            todateController.text.isNotEmpty &&
            startTimeController.text.isNotEmpty &&
            endTimeController.text.isNotEmpty &&
            priceController.text.isNotEmpty &&
            capacityController.text.isNotEmpty &&
            eventImage != null
        //  &&
        // address != ''
        ) {
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
    final tempImage = await _imageSelectorApi.selectImageForCropper();
    cropImage(tempImage);
    update();
  }

  cropImage(pickedImage) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatioPresets: aspectRatios,
      uiSettings: uiSetting(androidTitle: 'Crop Image', iosTitle: 'Crop Image'),
    );
    if (croppedImage != null) {
      // bool userConfirmed = await showConfirmationDialog(Get.context!);

      // if (userConfirmed) {
        eventImage = File(croppedImage.path);
      // }
    } else {
      UiUtilites.errorSnackbar('Image selection failed'.tr,
          'Failed to select image, please try again.'.tr);
    }
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
    busyController.setBusy(true);
    final eventId = DateTime.now().millisecondsSinceEpoch.toString();
    CloudStorageResult? imageResult = await _saveEventImage(eventId);
    if (imageResult!.imageUrl != '') {
      await _eventService.createEvent(
          event: TrainerEvent(
        id: eventId,
        title: eventTitleController.text,
        price: priceController.text,
        date: dateController.text,
        todate: todateController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        trainerId: currentUser!.id,
        capacity: capacityController.text,
        imageUrl: imageResult.imageUrl,
        imageFileName: imageResult.imageFileName,
        address: address,
        eventType: selectedOption == 1 ? EventType.paid : EventType.free,
        paymentStatus: PaymentStatus.pending,
        eventStatus: EventStatus.open,
      ));
      if (selectedOption == 1) {
        busyController.setBusy(false);
        Get.toNamed(AppRoutes.eventcheckout, arguments: eventId)!;
        clearValues();
      } else {
        clearValues();

        UiUtilites.successAlert(Get.context, 'Event Shared Successfully'.tr);
        busyController.setBusy(false);
      }
    }
  }

  clearValues() {
    eventTitleController.clear();
    priceController.clear();
    dateController.clear();
    todateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    capacityController.clear();
    selectedOption = 1;
    address = '';
    eventImage = null;
    areFieldsFilled.value = false;
  }
}
