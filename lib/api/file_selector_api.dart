import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'package:mudarribe_trainer/values/ui_utils.dart';

class FileSelectorApi {
  selectFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);
    if (pickedFile != null) {
      return File(pickedFile.paths.first!);
    } else {
      UiUtilites.errorSnackbar('File selection failed'.tr,
          'Failed to select file, please try again.'.tr);
      // throw FileSelectorApiException(
      //   title: 'File selection failed',
      //   message: 'Failed to select file, please try again.',
      // );
    }
  }

  selectMultipleFiles() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'mp4',
      ],
      allowMultiple: true,
    );

    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      List<File> selectedFiles =
          pickedFiles.files.map((file) => File(file.path!)).toList();

      return selectedFiles;
    } else {
      UiUtilites.errorSnackbar('File selection failed'.tr,
          'Failed to select file, please try again.'.tr);
    }
  }

  selectMp4Files() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'mp4',
      ],
      allowMultiple: false,
    );

    if (pickedFiles != null) {
      return File(pickedFiles.paths.first!);
    } else {
      UiUtilites.errorSnackbar('File selection failed'.tr,
          'Failed to select file, please try again.'.tr);
    }
  }
}
