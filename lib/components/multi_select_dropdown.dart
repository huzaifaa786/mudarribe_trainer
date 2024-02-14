// ignore_for_file: use_full_hex_values_for_flutter_colors, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:multiselect/multiselect.dart';

class MultiSelectDropDown extends StatelessWidget {
  const MultiSelectDropDown(
      {super.key,
      this.label,
      this.item,
      this.onchange,
      this.selected,});
  final label;
  final item;
  // final String Function(dynamic)? validator;
  final Function(List<dynamic>)? onchange;
  final selected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: Get.width,
      child: DropDownMultiSelect(
        // validator: validator,
        decoration: InputDecoration(
            label: Text(label),
            labelStyle: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          colors: const [Color(4285693389), Color(4284015103)])
                      .createShader(Rect.fromLTWH(0, 0, 200, 15))),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: GradientOutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Color(4285693389), Color(4278253801)]),
              width: 1,
            ),
            enabledBorder: GradientOutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Color(4285693389), Color(4278253801)]),
              width: 1,
            ),
            focusedBorder: GradientOutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Color(4285693389), Color(4278253801)]),
              width: 1,
            ),
            // errorBorder: GradientOutlineInputBorder(
            //   borderRadius: BorderRadius.circular(2),
            //   gradient: const LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomLeft,
            //       colors: [Colors.red, Colors.red]),
            //   width: 1,
            // ),
            // errorStyle: TextStyle(fontSize: 0)
            // errorMaxLines: ,
            ),
        selected_values_style: TextStyle(color: Colors.white),
        onChanged: onchange!,
        options: item,
        selectedValues: selected,
        whenEmpty: '',
      ),
    );
  }
}
