import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;

import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/views/app_theme/theme_method.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key, this.lang});

  final String? lang;

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

enum themeMethod { Light, Dark }

class _ThemeScreenState extends State<ThemeScreen> {
  themeMethod? _site;
  toggleplan(themeMethod value) {
    setState(() {
      _site = value;
    });
  }

  @override
  void initState() {
    // print(Get.locale);
    GetStorage box = GetStorage();
    box.read('theme') == 'light';
    _site = box.read('theme') != 'dark' ? themeMethod.Light : themeMethod.Dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: TopBar(text: "Theme".tr),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              ThemeMethod(
                title: 'Light'.tr,
                groupvalue: _site,
                value: themeMethod.Light,
                onchaged: () async {
                  await toggleplan(themeMethod.Light);
                  GetStorage box = GetStorage();
                  await box.write('theme', 'light');
                  box.read('theme');
                  Get.changeThemeMode(ThemeMode.light);
                  setState(() {});
                  // Get.toNamed(AppRoutes.homeScreen);

                },
              ),
              ThemeMethod(
                title: 'Dark'.tr,
                groupvalue: _site,
                value: themeMethod.Dark,
                onchaged: () async {
                  await toggleplan(themeMethod.Dark);
                  GetStorage box = GetStorage();
                  await box.write('theme', 'dark');
                  box.read('theme');
                  Get.changeThemeMode(ThemeMode.dark);
                  setState(() {});
                  // Get.toNamed(AppRoutes.homeScreen);
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
