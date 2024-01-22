import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/services/package_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class EditPlanController extends GetxController {
  static EditPlanController instance = Get.find();
  final BusyController busyController = Get.find();

  TextEditingController packagenameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  final _packageService = PackageService();

  String selected = '';
  Package? package;

  String category = '';

  onnutritiontap() {
    category = 'nutrition';
    update();
    checkFields();
  }

  onexcercisetap() {
    category = 'excercise';

    update();
    checkFields();
  }

  onbothtap() {
    category = 'excercise&nutrition';
    update();
    checkFields();
  }

  void onInit() {
    packagenameController.addListener(() {
      checkFields();
    });
    priceController.addListener(() {
      checkFields();
    });
    durationController.addListener(() {
      checkFields();
    });
    discriptionController.addListener(() {
      checkFields();
    });

    super.onInit();
  }

  void checkFields() {
    if (packagenameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        discriptionController.text.isNotEmpty &&
        category != '') {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  onclick() {
    selected = 'click';

    update();
  }

  Future<void> getTrainerPackage(id) async {
    package = await _packageService.getTrainerPackage(id: id);

    packagenameController.text = package!.name!;
    priceController.text = package!.price!;
    durationController.text = package!.duration!;
    discriptionController.text = package!.discription!;
    category = package!.category!;

    checkFields();
    update();
  }

  Future updatePackage() async {
    busyController.setBusy(true);
    await _packageService.updatePackage(id: package!.id, Package: {
      'name': packagenameController.text,
      'price': priceController.text,
      'duration': durationController.text,
      'discription': discriptionController.text,
      'category': category,
    });
    busyController.setBusy(false);
    Get.back();
    UiUtilites.successAlert(Get.context, 'Package Edit\nSuccessfully !'.tr);
  }
}
