import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/values/color.dart';

class PdfCard extends StatelessWidget {
  const PdfCard({
    super.key,
    this.title,
    this.description,
    this.onPressed,
    this.onDeleteTap,
  });
  final title;
  final description;
  final onPressed;
  final onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Get.isDarkMode?const Color(0x872C2723): Colors.grey.withOpacity(0.2),
          
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onPressed,
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [borderTop, borderbottom],
                          )),
                      child: Image.asset('assets/images/dieticon.png'),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                            color:  Get.isDarkMode? white: maincolor ,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(description,
                          style: TextStyle(
                            color:  Get.isDarkMode? white: maincolor ,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: onDeleteTap,
              child: SvgPicture.asset('assets/images/delete.svg')),
        ],
      ),
    );
  }
}
