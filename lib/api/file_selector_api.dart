import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';

class FileSelectorApi {
  selectFile() async {
    final pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf'],allowMultiple: false);
    if (pickedFile != null) {
      print(pickedFile.files.first.name);
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
}
