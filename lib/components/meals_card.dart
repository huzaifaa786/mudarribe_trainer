import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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
                                child: Image.asset(
                                  snapshot.data != null
                                      ? snapshot.data!
                                      : 'assets/images/containimg.jpeg',
                                  width:
                                      120, // Specify the width of the image to fit the Container
                                  height:
                                      77, // Specify the height of the image to fit the Container
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
                    Text(title,
                        maxLines: 1,
                        style: const TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(description,
                        style: const TextStyle(
                          color: white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ),
              ],
            ),
          ),
          InkWell(onTap: onDeleteTap, child: SvgPicture.asset('assets/images/delete.svg')),
        ],
      ),
    );
  }
}
