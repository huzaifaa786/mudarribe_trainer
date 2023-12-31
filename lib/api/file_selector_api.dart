import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:mudarribe_trainer/exceptions/file_selector_api_exception.dart';

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
      UiUtilites.errorSnackbar(
          'File selection failed', 'Failed to select file, please try again.');
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
      UiUtilites.errorSnackbar(
          'File selection failed', 'Failed to select file, please try again.');

      throw FileSelectorApiException(
        title: 'File selection failed',
        message: 'Failed to select file, please try again.',
      );
    }
  }
}
