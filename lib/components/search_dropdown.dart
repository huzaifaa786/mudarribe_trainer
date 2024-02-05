import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:mudarribe_trainer/values/color.dart';
// import 'package:translation/values/colors.dart';

class SearchDropdownField extends StatelessWidget {
  const SearchDropdownField({
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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              // color: ,
            ),
          ),
          items: items!
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      '$item'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
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
                borderRadius: BorderRadius.circular(5),
                border: GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: const [borderTop, borderbottom],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    width: 1.0)
                // color: white,
                ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: const [borderTop, borderbottom],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    width: 1.0)),
          ),
          // iconStyleData:
          //     IconStyleData(icon: Image.asset('assets/images/drop_arrow.png')),

          /* Uncomment the below code to enable search */

          // dropdownSearchData: DropdownSearchData(
          //     searchController: searchController,
          //     searchInnerWidget: searchInnerWidget,
          //     searchMatchFn: searchMatchFn,
          //     searchInnerWidgetHeight: 70),
          // onMenuStateChange: onMenuStateChange,
        ),
      ),
    );
  }
}
