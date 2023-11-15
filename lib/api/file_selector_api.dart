import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mudarribe_trainer/exceptions/file_selector_api_exception.dart';


class FileSelectorApi {
  Future<File> selectFile() async {
    final pickedFile =
        await FilePicker.platform.pickFiles(allowedExtensions: ['pdf','doc','docx']);
    if (pickedFile != null) {
      return File(pickedFile.paths.first!);
    } else {
      throw FileSelectorApiException(
        title: 'File selection failed',
        message: 'Failed to select file, please try again.',
      );
    }
  }
}
