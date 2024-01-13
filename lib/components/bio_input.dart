// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/translation.dart';

class BioInputField extends StatefulWidget {
  const BioInputField({
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
  State<BioInputField> createState() => _BioInputFieldState();
}

class _BioInputFieldState extends State<BioInputField> {
  String? labelTranslation;
  translateLabel() async {
    labelTranslation = await translateText(widget.lable);
    setState(() {});
  }

  @override
  void initState() {
    translateLabel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 0, right: 0),
        child: TextFormField(
            readOnly: widget.readOnly,
            obscureText: widget.obscure,
            controller: widget.controller,
            validator: widget.validator,
            maxLines: 3,
            autovalidateMode: widget.autovalidateMode ??
                (widget.validator == true.obs
                    ? AutovalidateMode.always
                    : AutovalidateMode.onUserInteraction),
            style: TextStyle(color: Colors.white),
            keyboardType: widget.type,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // contentPadding: EdgeInsets.only(top: 60),
                fillColor: Colors.white,
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
                labelText: labelTranslation ?? '...',
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
