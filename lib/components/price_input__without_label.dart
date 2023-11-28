// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';

class PriceInputWithoutLabel extends StatelessWidget {
  const PriceInputWithoutLabel({
    Key? key,
    this.controller,
    this.hint,
    this.obscure = false,
    this.maxlines = false,
    this.readOnly = false,
    this.lable,
    this.validator,
    this.autovalidateMode,
    this.type = TextInputType.text,
  }) : super(key: key);

  final controller;
  final validator;
  final obscure;
  final hint;
  final type;
  final lable;
  final autovalidateMode;
  final maxlines;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readOnly,
        obscureText: obscure,
        controller: controller,
        validator: validator,
        autovalidateMode: autovalidateMode ??
            (validator == true.obs
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction),
        style: TextStyle(color: Colors.white),
        keyboardType: type,
        decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, right: 10),
              child: Text(
                '|   AED',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            border: GradientOutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Color(4285693389), Color(4278253801)]),
              width: 1,
            ),
            hoverColor: Colors.grey,
            focusColor: Colors.grey,
            // labelText: lable,
            hintText: hint,
            labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                foreground: Paint()
                  ..shader = LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: [Color(4285693389), Color(4284015103)])
                      .createShader(Rect.fromLTWH(0, 0, 200, 15)))));
  }
}
