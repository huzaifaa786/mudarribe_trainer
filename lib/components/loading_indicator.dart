import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/helpers/loading_helper.dart';
import 'package:mudarribe_trainer/models/app_user.dart';

class BusyIndicator extends StatelessWidget {
  final Widget child;


  const BusyIndicator(
      {required this.child});

  @override
  Widget build(BuildContext context) {
    final BusyController busyController = Get.find();
    return Obx(
      () => busyController.isBusy ? const BasicLoader() : child,
    );
  }
}
