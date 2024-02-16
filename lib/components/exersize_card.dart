import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/values/color.dart';

class ExersizeCard extends StatelessWidget {
  const ExersizeCard(
      {super.key,
      this.title,
      this.description,
      this.radiovalue,
      this.groupValue,
      this.onChanged});
  final title;
  final description;
  final radiovalue;
  final groupValue;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
           color: Get.isDarkMode ? const Color(0x872C2723) : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          // ListTile(
          //   title: const Text('Option 1'),
          //   leading: Radio(
          //     value: radiovalue,
          //     groupValue: groupValue,
          //     onChanged: onChanged
          //   ),
          // ),
          Transform.scale(
              scale: 1.2,
              child: Radio(
                  value: radiovalue.toString(),
                  groupValue: groupValue.toString(),
                  fillColor:
                      MaterialStateColor.resolveWith((states) => borderbottom),
                  onChanged: onChanged)),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset('assets/images/majesticons.svg'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: Get.isDarkMode ? white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
                Text(description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
