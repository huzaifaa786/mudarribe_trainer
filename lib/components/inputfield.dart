// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/translation.dart';

class InputField extends StatefulWidget {
  const InputField({
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
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 0, right: 0),
        child: TextFormField(
            readOnly: widget.readOnly,
            obscureText: widget.obscure,
            controller: widget.controller,
            validator: widget.validator,
            // autovalidateMode: AutovalidateMode.always,
            autovalidateMode: widget.autovalidateMode ??
                (widget.validator == true.obs
                    ? AutovalidateMode.always
                    : AutovalidateMode.onUserInteraction),
            style:
                TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
            keyboardType: widget.type,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // fillColor: Colors.white,
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
                // focusedBorder: GradientOutlineInputBorder(
                //   borderRadius: BorderRadius.circular(2),
                //   gradient: const LinearGradient(
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomLeft,
                //       colors: [Color(4285693389), Color(4278253801)]),
                //   width: 1,
                // ),
                // enabledBorder: GradientOutlineInputBorder(
                //   borderRadius: BorderRadius.circular(2),
                //   gradient: const LinearGradient(
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomLeft,
                //       colors: [Color(4285693389), Color(4278253801)]),
                //   width: 1,
                // ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.red), // Customize the error border color
                ),
                errorStyle: TextStyle(fontSize: 0),
                hoverColor: Colors.grey,
                focusColor: Colors.grey,
                labelText: widget.lable,
                hintText: widget.hint,
                labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    foreground: Paint()
                      ..shader = LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [Color(4285693389), Color(4284015103)])
                          .createShader(Rect.fromLTWH(0, 0, 200, 20))))));
  }
}
