import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/values/color.dart';

class TodayMealsScreen extends StatefulWidget {
  const TodayMealsScreen({super.key});

  @override
  State<TodayMealsScreen> createState() => _TodayMealsScreenState();
}

class _TodayMealsScreenState extends State<TodayMealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          TopBar(
            text: 'Today Meals',
          ),
          Container(
            padding: EdgeInsets.only(right: 15, left: 15, top: 15),
            child: Column(
              children: [
                Stack(
                  // alignment: Alignment.center,
                  children: [
                    // First asset image as the background
                    Image.asset(
                      'assets/images/updatebutton.png',
                      // width: 300,
                      // height: 300,
                      fit: BoxFit.cover,
                    ),
                    // Second asset image in the center
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 120),
                      child: Image.asset(
                        'assets/images/updateicon.png',
                        // width: 150,
                        // height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        //right: 40,

                        child: Padding(
                      padding: EdgeInsets.only(top: 18, left: 145),
                      child: Text('Upload New Files',
                          style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Color(0x872C2723),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.17,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff727dcd),
                                    Color(0xff58e0ff)
                                  ],
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
                            Text('Full Diet plan',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text('305 kb',
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
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Color(0x872C2723),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                           // padding: EdgeInsets.all(8.0),
                            width: 123,
                            height: 77,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0x562c2723)),
                            child: Image.asset(
                              'assets/images/imgcontainer.png',
                              width:
                                  120, // Specify the width of the image to fit the Container
                              height:
                                  77, // Specify the height of the image to fit the Container
                              fit: BoxFit.fill,
                            ),
                          )
                          // Image.asset('assets/images/img.png'),

                          // Stack(
                          //   alignment: Alignment.center,
                          //   children: [
                          //     SvgPicture.asset(
                          //         'assets/images/what.svg'),
                          //     Positioned(
                          //       right: 40,
                          //       left: 40,
                          //       child: SvgPicture.asset(
                          //           'assets/images/containercenterimg.svg',fit: BoxFit.cover,),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('01',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Full Body Energy',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 80, bottom: 45),
                        child: SvgPicture.asset('assets/images/delete.svg'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
