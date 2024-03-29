import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/image_selector_api.dart';
import 'package:mudarribe_trainer/api/report_storage_api.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/trainer_report.dart';
import 'package:mudarribe_trainer/services/report_service.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class ReportProblemController extends GetxController {
  static ReportProblemController instance = Get.find();
  final BusyController busyController = Get.find();
  final _imageSelectorApi = ImageSelectorApi();
  final _reportStorageApi = ReportStorageApi();
  final _reportService = ReportService();
  TextEditingController report = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int? i = 0;

  Future reportuploadimage() async {
    final tempImage = await _imageSelectorApi.selectImage();

    reportImage = tempImage;

    checkFields();
    update();
  }

  RxBool areFieldsFilled = false.obs;

  void checkFields() {
    if (report.text.isNotEmpty && reportImage != null) {
      areFieldsFilled.value = true;
      update();
    } else {
      areFieldsFilled.value = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAppUser();
    report.addListener(() {
      checkFields();
    });
  }

  clearValues() {
    report.clear();
    reportImage = null;
    areFieldsFilled.value = false;
  }

  File? reportImage;
  User? user;
  Future _saveReportImage(reportId) async {
    if (reportImage != null) {
      final CloudStorageResult storageResult =
          await _reportStorageApi.ReportuploadImage(
              eventId: reportId, imageToUpload: reportImage!);
      return storageResult;
    }
  }

  Future reportfun() async {
    busyController.setBusy(true);
    final reportId = DateTime.now().millisecondsSinceEpoch.toString();
    CloudStorageResult? imageResult = await _saveReportImage(reportId);

    TraineeReport traineeReport;

    if (imageResult?.imageUrl != '') {
      traineeReport = TraineeReport(
        id: reportId,
        title: report.text,
        imageUrl: imageResult?.imageUrl,
        imageFileName: imageResult?.imageFileName,
        traineeId: user!.uid,
      );
    } else {
      traineeReport = TraineeReport(
        id: reportId,
        title: report.text,
        traineeId: user!.uid,
      );
    }
    await _reportService.createReport(report: traineeReport);
    busyController.setBusy(false);
    UiUtilites.successAlert(Get.context, 'Report submit Successfully.'.tr);
    clearValues();
  }

  Future getAppUser() async {
    user = FirebaseAuth.instance.currentUser;
  }
}
