import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/storage_api_exception.dart';
import 'package:mudarribe_trainer/helpers/data_models.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class PostStorageApi {
  Future<CloudStorageResult> uploadPostImage({
    required String postId,
    required File imageToUpload,
  }) async {
    final imageFileName = "PI._$postId";

    final storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child("postImages/$postId/$imageFileName");

    try {
      final storage.UploadTask uploadTask =
          storageReference.putFile(imageToUpload);

      final storage.TaskSnapshot storageTaskSnapshot =
          await Future.value(uploadTask);

      final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      if (uploadTask.storage.bucket.isNotEmpty) {
        final url = downloadUrl.toString();
        return CloudStorageResult(
          imageUrl: url,
          imageFileName: imageFileName,
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

  Future<CloudStorageResult> uploadStoryImage({
    required String storyId,
    required File imageToUpload,
  }) async {
    final imageFileName = "SI._$storyId";

    final storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child("storyImages/$storyId/$imageFileName");

    try {
      final storage.UploadTask uploadTask =
          storageReference.putFile(imageToUpload);

      final storage.TaskSnapshot storageTaskSnapshot =
          await Future.value(uploadTask);

      final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      if (uploadTask.storage.bucket.isNotEmpty) {
        final url = downloadUrl.toString();
        return CloudStorageResult(
          imageUrl: url,
          imageFileName: imageFileName,
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

  Future<CloudStorageResult> uploadStorymp4({
    required String storyId,
    required File videoToUpload,
  }) async {
    final videoFileName = "SI._$storyId";

    final storage.Reference storageReference = storage.FirebaseStorage.instance
        .ref()
        .child("storyImages/$storyId/$videoFileName");

    try {
      final storage.UploadTask uploadTask =
          storageReference.putFile(videoToUpload);

      final storage.TaskSnapshot storageTaskSnapshot =
          await Future.value(uploadTask);

      final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      if (uploadTask.storage.bucket.isNotEmpty) {
        final url = downloadUrl.toString();
        return CloudStorageResult(
          imageUrl: url,
          imageFileName: videoFileName,
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
}
