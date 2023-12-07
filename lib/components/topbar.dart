import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopBar extends StatelessWidget {
  final  text;


  const TopBar({Key? key,  this.text, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/nevigate.svg',
          ),
          const SizedBox(
            width: 15,
          ),
          Text(text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))
        ],
      ),
    );
  }
}
