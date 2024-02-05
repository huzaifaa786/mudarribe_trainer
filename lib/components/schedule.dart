// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';

class Scheduleinput extends StatelessWidget {
  const Scheduleinput(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscure = false,
      this.showSuffix = false,
      this.validator,
      this.autovalidateMode,
      this.validate,
      this.suffix,
      this.type = TextInputType.text,
      this.fontSize = 14.0,
      this.width = 0.4,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final bool? validate;
  final hint;
  final width;
  final type;
  final showSuffix;
  final suffix;
  final obscure;
  final text;
  final autovalidateMode;
  final maxlines;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: white.withOpacity(0.45)),
            ) ,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.4,
            child: TextFormField(
              readOnly: true,
              onTap: onpressed,
              enabled: enabled,
              obscureText: obscure,
              controller: controller,
              style: TextStyle(fontSize: fontSize, color: white),
              keyboardType: type,
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    enabled ? Colors.black : Colors.grey.withOpacity(0.5),
                hintText: hint,
                contentPadding: const EdgeInsets.only(
                    left: 12.0, right: 12, top: 12, bottom: 16),
                hintStyle: TextStyle(color: white.withOpacity(0.5)),
                enabledBorder: GradientOutlineInputBorder(
                  gradient: LinearGradient(
                      colors: [borderTop, borderbottom],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  width: 1,
                ),
                focusedBorder: GradientOutlineInputBorder(
                  gradient: LinearGradient(
                      colors: [borderTop, borderbottom],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  width: 1,
                ),
              ),
              // cursorColor: Colors.black,
              maxLines: maxlines == true ? null : 1,
            ),
          ),
        ],
      ),
    );
  }
}
