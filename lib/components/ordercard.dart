import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/values/color.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 140,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Image.asset('assets/images/person.png'),
              
              Text('package',style: TextStyle(color: Colors.blue),),
                Text('price',style: TextStyle(color: Colors.blue),)
              
              
              ],
            ),
            SizedBox(width: 23,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Ahmad Khan',style: TextStyle(color: White,fontSize: 20),),
            Text('1 month Lose Wieght Plan',style: TextStyle(color: White,fontSize: 16)),
            Text('250.44 AED',style: TextStyle(color: White,fontSize: 16))],),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [Image.asset('assets/images/chat.png'),
              Text('Send plan',style: TextStyle(color: White,fontSize: 14))
              ],)
          ],
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 22, 22, 22),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 44, 42, 42),
              offset: const Offset(0.0, 0.0),
              blurRadius: 4.0,
              spreadRadius: 4.0,
            ), //BoxShadow
          ],
        ),
      ),
    );
  }
}
