import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';

class InputFieldPrice extends StatelessWidget {
  const InputFieldPrice({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: white.withOpacity(0.4),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.only(top: 5),
            child: TextField(
              // obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                     suffixIcon: const Align(alignment: Alignment.centerRight,child: Text('|  AED      ',style: TextStyle(color: white),)),
                border: GradientOutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff727dcd), Color(0xff00f8e9)]),
                  width: 1,
                ),
                // hintText: '22:30',
               
              ),
            ),
          ),
        ],
      ),
    );
  }
}
