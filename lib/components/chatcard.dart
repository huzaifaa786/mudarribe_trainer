import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {super.key, this.name, this.message, this.selected, this.image});
  final message;
  final name;
  final selected;
  final image;

  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 22,
                    right: 22,
                  ),
                  child: Container(
                    height: 80,
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/Rectangle 31.png'),
                              fit: BoxFit
                                  .cover, // You can specify how the image should be fitted within the circle
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, right: 14),
                                        child: Text(
                                          'you should say  ..',
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '3 New Messages',
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
  }
}