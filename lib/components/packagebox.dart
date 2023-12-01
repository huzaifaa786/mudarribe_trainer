// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: bgContainer, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: ontap,
                child: Image.asset('assets/images/edit.png'),
              ),
              InkWell(
                onTap: onPressed,
                child: SvgPicture.asset(
                  'assets/images/delete.svg',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image == 'nutrition'
                  ? SvgPicture.asset(
                      'assets/images/nutrition.svg',
                      color: const Color.fromARGB(255, 49, 141, 216),
                      width: 35,
                      height: 35,
                    )
                  : image == 'exercise'
                      ? SvgPicture.asset(
                          'assets/images/excercise.svg',
                          color: const Color.fromARGB(255, 49, 141, 216),
                          width: 35,
                          height: 35,
                        )
                      : Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/nutrition.svg',
                              color: const Color.fromARGB(255, 49, 141, 216),
                              width: 35,
                              height: 35,
                            ),
                            Text(' + '),
                            SvgPicture.asset(
                              'assets/images/excercise.svg',
                              color: const Color.fromARGB(255, 49, 141, 216),
                              width: 35,
                              height: 35,
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
                      child: Text(discription.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          )),
                    )
                  ],
                ),
              )
            ],
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
