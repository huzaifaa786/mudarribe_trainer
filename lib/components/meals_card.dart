import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mudarribe_trainer/values/color.dart';

class MealsCard extends StatelessWidget {
  const MealsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imgpath1,
  });
  final String title;
  final String description;
  final String imgpath1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: const Color(0x872C2723), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      imgpath1,
                      // 'assets/images/containimg.jpeg'
                      width:
                          120, // Specify the width of the image to fit the Container
                      height:
                          77, // Specify the height of the image to fit the Container
                      fit: BoxFit.fill,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'assets/images/gridicon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Text(description,
                    style: const TextStyle(
                      color: white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, bottom: 45),
            child: SvgPicture.asset('assets/images/delete.svg'),
            // 'assets/images/delete.svg'
          ),
        ],
      ),
    );
  }
}
