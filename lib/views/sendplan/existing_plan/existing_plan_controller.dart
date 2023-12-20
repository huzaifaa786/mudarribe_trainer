// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mudarribe_trainer/api/file_selector_api.dart';
import 'package:mudarribe_trainer/api/plan_storage_api.dart';
import 'package:mudarribe_trainer/api/planfile_api.dart';
import 'package:mudarribe_trainer/enums/enums.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/api/plan_api.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/plan.dart';
import 'package:mudarribe_trainer/models/plan_file.dart';
import 'package:mudarribe_trainer/services/planfile_service.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ExistingPlanController extends GetxController {
  static ExistingPlanController instance = Get.find();

  final BusyController busyController = Get.find();
  Plan? plan;
  List<PlanFile> planfiles = [];
  List<File> selectedFiles = [];
  String userId = '';
  String orderId = '';
  String planId = '';
  final _planfileService = PlanFileService();
  final _planApi = PlanApi();
  final _planFileApi = PlanFileApi();
  final _fileSelectorApi = FileSelectorApi();
  final _planfileStorageApi = PlanStorageApi();

  Future getTrainerFiles() async {
    plan = await _planApi.getPlanById(planId);
    planfiles = await _planfileService.getTrainerFiles(planId: planId);

    update();
  }

  Future selectmultipleFiles() async {
    busyController.setBusy(true);
    final tempFile = await _fileSelectorApi.selectMultipleFiles();
    selectedFiles = tempFile;
    update();

    if (selectedFiles != []) {
      await storeplanfiles(planId);
    }
    busyController.setBusy(false);
  }

  Future sendPlan() async {
    busyController.setBusy(true);
    final planFileId = DateTime.now().millisecondsSinceEpoch.toString();
    await _planApi.sendPlan(planFileId, {
      "id": planFileId,
      "userId": userId,
      "planId": planId,
      "orderId": orderId,
      "trainerId": FirebaseAuth.instance.currentUser!.uid,
    });

    busyController.setBusy(false);
    Get.offNamed(AppRoutes.orders);
     UiUtilites.successAlert(Get.context, 'Plan Sent Successfully');

  }

  Future storeplanfiles(String planId) async {
    for (File file in selectedFiles) {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final fileExtension = extension(file.path);
      final fileName = basenameWithoutExtension(file.path);
      CloudStorageResult cloudStorageResult =
          await _planfileStorageApi.uploadPlanFile(
              planFileId: id, fileToUpload: file, extentsion: fileExtension);
      await _planfileService.createPlanFile(
          planfile: PlanFile(
              id: id,
              planId: planId,
              fileType: fileExtension == '.pdf' ? FileType.pdf : FileType.mp4,
              fileName: fileName,
              fileUrl: cloudStorageResult.imageUrl,
              FileId: cloudStorageResult.imageFileName));
    }
    await getTrainerFiles();
  }

  Future<String?> genrateVideoThumbnail(url) async {
    final fileName = VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );

    return fileName;
  }

  Future deleteFile(PlanFile planFile) async {
    if (planFile.FileId != null && planFile.fileName != null) {
      await _planfileStorageApi.deletePlanFile(planFile.id, planFile.FileId!);
      bool isDeleted = await _planFileApi.deleteFile(planFile.id);
      await getTrainerFiles();

      Get.back();
      UiUtilites.successAlert(Get.context, 'File Deleted Successfully');
    }
  }

  Future<File> createFileOfPdfUrl(pdf) async {
    Completer<File> completer = Completer();

    try {
      final url = pdf;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
