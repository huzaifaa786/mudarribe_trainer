// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class DropInputField extends StatelessWidget {
  const DropInputField({
    Key? key,
    this.controller,
    this.hint,
    this.value,
    this.onChanged,
    this.items,
    this.label,
  }) : super(key: key);

  final controller;
  final hint;
  final value;
  final onChanged;
  final items;
  final label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 0, right: 0),
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: GradientOutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff727dcd), Color(0xff00f8e9)]),
              width: 1,
            ),
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              foreground: Paint()
                ..shader = const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff727dcd), Color(0xff58e1ff)],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 20)),
            ),
          ),
        ),
      ),
    );
  }
}
