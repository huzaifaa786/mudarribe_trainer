import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/values/color.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    @required this.title,
    @required this.onPressed,
    this.selected = false, // Default value is false
  }) : super(key: key);

  final title;
  final onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: selected
                  ? [borderTop, borderbottom]
                  : [const Color.fromARGB(255, 26, 25, 25), const Color.fromARGB(255, 26, 25, 25)],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 44, 42, 42),
                offset: const Offset(0.0, 0.0),
                blurRadius: 4.0,
                spreadRadius: 4.0,
              ), //BoxShadow
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
