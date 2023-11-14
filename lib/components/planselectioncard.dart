// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mudarribe_trainer/values/color.dart';

class SelectPlanCard extends StatelessWidget {
  const SelectPlanCard(
      {super.key,
      this.image,
      this.ontap,
      this.selected,
      this.image1,
      this.text});
  final ontap;
  final image;
  final image1;
  final selected;
  final text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    border: selected == true
                        ? GradientBoxBorder(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [borderTop, borderbottom]),
                            width: 3,
                          )
                        : Border.all(),
                    color: Color.fromARGB(255, 22, 22, 22),
                  
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(image),
                      Icon(Icons.add,color: white,size: 29,),
                      SvgPicture.asset(image1),
                    ],
                  ),
                ),
              ),
              // selected == true
              //     ? Positioned(
              //       right: 12,
              //       top: 8,
              //         child: Icon(
              //         Icons.check_circle,
              //         color: mainColor,
              //       ))
              //     : Positioned(child: Text(''))
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: white,),
        )
      ],
    );
  }
}
