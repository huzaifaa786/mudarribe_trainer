import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/storage_api_exception.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class PlanStorageApi {
  Future<CloudStorageResult> uploadPlanFile({
    required String planFileId,
    required File fileToUpload,
  }) async {
    final fileName = "PF._$planFileId";

    final storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child("planFiles/$planFileId/$fileName");

    try {
      final storage.UploadTask uploadTask =
          storageReference.putFile(fileToUpload);

      final storage.TaskSnapshot storageTaskSnapshot =
          await Future.value(uploadTask);

      final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      if (uploadTask.storage.bucket.isNotEmpty) {
        final url = downloadUrl.toString();
        return CloudStorageResult(
          imageUrl: url,
          imageFileName: fileName,
        );
      } else {
        throw StorageApiException(
          title: 'Server Error',
          message: 'An error occured while uploading the image.',
        );
      }
    } on PlatformException catch (e) {
      throw StorageApiException(
        title: 'Failed to upload image',
        message: e.message,
      );
    }
  }

  Future<bool> deletePlanImage(
    String PlanId,
    String imageFileName,
  ) async {
    final storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child("PlanImages/$PlanId/$imageFileName");

    try {
      bool result = false;

      await storageReference.delete().then(
            (_) => result = true,
          );

      return result;
    } on PlatformException catch (e) {
      throw StorageApiException(
        title: 'Failed to upload image',
        message: e.message,
      );
    }
  }
}
