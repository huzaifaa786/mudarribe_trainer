// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/values/color.dart';

class PackageCard extends StatelessWidget {
  const PackageCard(
      {super.key,
      this.ontap,
      this.name,
      this.discription,
      this.price,
      this.onPressed,
      this.image});
  final ontap;
  final name;
  final onPressed;
  final discription;
  final price;
  final image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: bgContainer, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: ontap,
                child: Image.asset('assets/images/edit.png'),
              ),
              // InkWell(
              //   onTap: onPressed,
              //   child: SvgPicture.asset(
              //     'assets/images/delete.svg',
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Padding(
              padding: const EdgeInsets.only(left:35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image == 'nutrition'
                      ? SvgPicture.asset(
                          'assets/images/nutrition.svg',
                          width: 25,
                          height: 25,
                        )
                      : image == 'excercise'
                          ? SvgPicture.asset(
                              'assets/images/excercise.svg',
                              width: 25,
                              height: 25,
                            )
                          : Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/nutrition.svg',
                                  width: 25,
                                  height: 25,
                                ),
                                Text(' + '),
                                SvgPicture.asset(
                                  'assets/images/excercise.svg',
                                  width: 25,
                                  height: 25,
                                )
                              ],
                            ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(discription.toString(),
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(price.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              Text("  AED",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  )) 
            ],
          )
        ],
      ),
    );
  }
}
