import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/values/color.dart';

class MealsCard extends StatelessWidget {
  const MealsCard({
    super.key,
    this.title,
    this.description,
    this.imgpath1,
    this.onPressed,
    this.futureFunc,
    this.onDeleteTap,
  });
  final title;
  final description;
  final imgpath1;
  final onPressed;
  final onDeleteTap;
  final futureFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: const Color(0x872C2723),
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        FutureBuilder<String?>(
                            future: futureFunc,
                            builder: (context, snapshot) {
                              return ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: snapshot.data != null
                                    ? Image.file(
                                        File(snapshot.data!),
                                        width: 80,
                                        height: 77,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        'assets/images/containimg.png',
                                        width: 80,
                                        height: 77,
                                        fit: BoxFit.fill,
                                      ),
                              );
                            }),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            'assets/images/gridicon.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.5,
                      child: Text(title,
                          maxLines: 2,
                          style: const TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: Text(description,
                          style: const TextStyle(
                            color: white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          )),
                    )
                  ],
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
