// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';

class MainUserCard extends StatelessWidget {
  const MainUserCard({super.key, this.img, this.name, this.category,this.onUserImgTap});
  final img;
  final name;
  final category;
  final onUserImgTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: bgContainer.withOpacity(0.6),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 8,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: onUserImgTap,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: GradientBoxBorder(
                          gradient: LinearGradient(colors: [
                            Color(4290773187),
                            borderTop,
                            borderTop,
                            borderbottom
                          ]),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          img,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset('assets/images/verifiedicon.png')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(category,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.45),
                      fontSize: 14,
                      fontWeight: FontWeight.w400))
            ],
          ),
        ));
  }
}
