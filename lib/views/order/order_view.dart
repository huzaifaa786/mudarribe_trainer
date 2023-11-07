import 'package:flutter/material.dart';
import 'package:mudarribe_trainer/components/ordercard.dart';
import 'package:mudarribe_trainer/values/color.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                  children: [
          
             Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  SizedBox(width: 23,),
                  Text('Orders',style: TextStyle(color:White,fontSize: 28),)
                ],
              ),
              SizedBox(height: 30,),
              OrderCard(),
                OrderCard(),
                  OrderCard(),
                  ],
                ),
          )),
    );
  }
}
