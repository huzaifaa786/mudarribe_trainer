import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';

class TopBar extends StatelessWidget {
  final text;

  const TopBar({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/nevigate.svg',
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text('$text'.tr,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
