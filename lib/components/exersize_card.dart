import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mudarribe_trainer/values/color.dart';

class ExersizeCard extends StatelessWidget {
  const ExersizeCard(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Color(0x872C2723), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20, right: 20),
            child: SvgPicture.asset('assets/images/ellipseimg.svg'),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: SvgPicture.asset('assets/images/majesticons.svg'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                
                    style: TextStyle(
                      color: white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
                Text(description,
                
                    style: TextStyle(
                      color: white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
