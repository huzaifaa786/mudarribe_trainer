  import 'package:permission_handler/permission_handler.dart';

Future<bool> getpermission() async {
    bool serviceEnabled = false;

    Permission mediaLocation = await Permission.accessMediaLocation;
    Permission permission = await Permission.manageExternalStorage;
    Permission storagepermission = await Permission.storage;
    Permission cameraPermission = await Permission.camera;
    Permission mediaPermission = await Permission.mediaLibrary;
    if (permission.status.isGranted == false &&
        storagepermission.status.isGranted == false &&
        cameraPermission.status.isGranted == false &&
        mediaPermission.status.isGranted == false &&
        mediaLocation.status.isGranted == false) {
      return serviceEnabled;
    } else {
      return serviceEnabled = true;
    }
  }