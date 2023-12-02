import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/services/package_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class EditPlanController extends GetxController {
  static EditPlanController instance = Get.find();

  TextEditingController packagenameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  RxBool areFieldsFilled = false.obs;
  final _packageService = PackageService();

  String selected = '';
  Package? package; // Change packages to package

  String category = '';

  onnutritiontap() {
    category = 'nutrition';
    update();
    return category;
  }

  onexcercisetap() {
    category = 'excercise';
    update();
    return category;
  }

  onbothtap() {
    category = 'excercise&nutrition';
    update();
      checkFields();
    return category;
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
  //   onchange(List<dynamic> x) {
  //   selectedCategories = x.cast<String>();
  //   checkFields();
  //   update();
  // }

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
    print(selected);
    update();
  }

  Future<void> getTrainerPackage(id) async {
    package = await _packageService.getTrainerPackage(id: id);

    packagenameController.text = package!.name!;
    priceController.text = package!.price!;
    durationController.text = package!.duration!;
    discriptionController.text = package!.discription!;
    category = package!.category!;

    print(package!.name);
    checkFields();
    update();
  }

  Future updatePackage() async {
    await _packageService.updatePackage(id: package!.id, Package: {
      'name': packagenameController.text,
      'price': priceController.text,
      'duration': durationController.text,
      'discription': discriptionController.text,
      'category': category,
    });
     Get.back();
    UiUtilites.successAlert(Get.context, 'Package Edit\nSuccessfully !');
  }
}
