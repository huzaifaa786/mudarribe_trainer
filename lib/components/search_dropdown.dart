// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    Key? key,
    this.controller,
    this.selectedvalue,
    this.text,
    this.icon,
    this.imageIcon,
    this.color = maincolor,
    this.items,
    this.maxlines = false,
    this.onChange,
    this.type = TextInputType.text,
    this.onpressed,
    this.searchController,
    this.searchInnerWidget,
    this.searchMatchFn,
    this.onMenuStateChange,
  }) : super(key: key);

  final controller;
  final List? items;
  final selectedvalue;
  final type;
  final text;
  final icon;
  final imageIcon;
  final color;
  final maxlines;
  final onChange;
  final onpressed;

  // Searchable dropdown specific parameters
  final TextEditingController? searchController;
  final Widget? searchInnerWidget;
  final bool Function(dynamic item, String searchValue)? searchMatchFn;
  final void Function(bool isOpen)? onMenuStateChange;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              hint: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  color: white.withOpacity(0.45),
                ),
              ),
              items: items!
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style: const TextStyle(fontSize: 14, color: white),
                        ),
                      ))
                  .toList(),
              value: selectedvalue,
              onChanged: (value) {
                onChange(value);
              },
              buttonStyleData: ButtonStyleData(
                height: 55,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(colors: [borderTop, borderbottom]),
                    width: 1,
                  ),
                  color: Colors.black,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
                width: 200,
                offset: Offset(200, 0),
                decoration: BoxDecoration(
                  color: bgContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(colors: [borderTop, borderbottom]),
                    width: 1,
                  ),
                ),
              ),
              iconStyleData: IconStyleData(
                  iconEnabledColor: white, iconDisabledColor: white),
              dropdownSearchData: DropdownSearchData(
                  searchController: searchController,
                  searchInnerWidget: searchInnerWidget,
                  searchMatchFn: searchMatchFn,
                  searchInnerWidgetHeight: 70),
              onMenuStateChange: onMenuStateChange,
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 10,
          child: Container(
            padding: EdgeInsets.only(left: 4, right: 4),
            color: Colors.black,
            child: GradientText(
              'Category Of Train',
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500),
              colors: [borderTop, borderbottom],
            ),
          ),
        ),
      ],
    );
  }
}
