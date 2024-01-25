// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

class TitleTopBar extends StatelessWidget {
  const TitleTopBar({super.key, this.name, this.ontap});
  final name;
  final ontap;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        // width: MediaQuery.sizeOf(context).width,
        child: InkWell(
          onTap: ontap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ) ,
            ],
          ),
        ),
      ),
    );
  }
}
