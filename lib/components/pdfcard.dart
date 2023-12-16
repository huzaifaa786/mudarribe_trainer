import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mudarribe_trainer/values/color.dart';

class PdfCard extends StatelessWidget {
  const PdfCard({
    super.key,
    this.title,
    this.description,
    this.onPressed,
  });
  final title;
  final description;

  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: const Color(0x872C2723),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.17,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xff727dcd), Color(0xff58e0ff)],
                    )),
                child: Image.asset('assets/images/dieticon.png'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: 5,
                ),
                Text(description,
                    style: TextStyle(
                      color: white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 135, bottom: 35),
            child: SvgPicture.asset('assets/images/delete.svg'),
          ),
        ],
      ),
    );
  }
}
