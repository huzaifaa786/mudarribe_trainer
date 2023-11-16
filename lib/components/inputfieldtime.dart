import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mudarribe_trainer/values/color.dart';

class InputFieldTime extends StatelessWidget {
  const InputFieldTime({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding:  EdgeInsets.only(top: 10),
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
          SizedBox(width: 10), 
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            padding: EdgeInsets.only(top: 5),
            child: TextField(
             // obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: GradientOutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [Color(4285693389), Color(4278253801)]),
                  width: 1,
                ),
               // hintText: '22:30',
                 prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('22'),
                    VerticalDivider(
                      color: Colors.amber, // Customize divider color
                      thickness: 3, // Adjust divider thickness
                      width: 10, // Set divider width
                    ),
                    Text('30'),
                  ],
                ),
              ),
            ),
          ),
           VerticalDivider(
                  color: Colors.white, // Change divider color as needed
                  thickness: 1, // Adjust the thickness of the divider
                  width: 10, // Set the width of the divider
                ),
        ],
      ),
    );
  }
}
