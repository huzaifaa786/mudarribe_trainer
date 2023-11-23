// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/basic_loader.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/views/home/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeContoller>(
      builder: (controller) => controller.currentUser != null
          ? Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Color(0x512c2723), // Background color

                          shape: BoxShape.rectangle, // Shape of the container
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.1), // Shadow color with opacity
                              spreadRadius: 8, // Spread radius
                              blurRadius: 10, // Blur radius
                              offset: Offset(0, 3), // Offset (x, y)
                            ),
                          ],
                        ),
                        // child: Container(
                        //   height: 66,
                        //   width: 66,
                        //   padding: const EdgeInsets.all(2),
                        //   decoration: BoxDecoration(
                        //       //borderRadius: BorderRadius.circular(30),
                        //       borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(30),
                        //           topRight: Radius.circular(30),
                        //           bottomLeft: Radius.circular(30),
                        //           bottomRight: Radius.circular(30)),
                        //       gradient: const LinearGradient(
                        //         colors: [Colors.purple, Colors.blue],
                        //       )),
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(30),
                        //       color: Colors.white,
                        //     ),
                        //     child: Center(
                        //       child: Image.asset(
                        //         'assets/images/profile.png', // Replace 'your_image.png' with your actual image asset path
                        //         width:
                        //             100, // Set the width of the image as per your requirement
                        //         height:
                        //             100, // Set the height of the image as per your requirement
                        //         fit: BoxFit
                        //             .contain, // Adjust the fit property as needed to fit the image within the container
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // child: Container(
                        //   width: 100, // Set the width of the container
                        //   height: 100, // Set the height of the container

                        //   child: Center(
                        //     child: Container(
                        //       width:
                        //           90, // Set the width of the inner container slightly smaller than the outer container
                        //       height:
                        //           90, // Set the height of the inner container slightly smaller than the outer container
                        //       // decoration: BoxDecoration(
                        //       //   borderRadius: BorderRadius.circular(
                        //       //       15), // Set the border radius to match the outer container
                        //       //   //color: Colors
                        //       //       .white, // Set the background color of the inner container
                        //       // ),
                        //       child: Center(
                        //         child: Container(
                        //           height: 90,
                        //           width: 100,
                        //           decoration: BoxDecoration(
                        //             // borderRadius: BorderRadius.circular(
                        //             //     32), // Set the border radius to make it round
                        //             borderRadius: BorderRadius.only(

                        //                 topLeft: Radius.circular(40),
                        //                 topRight: Radius.circular(40),
                        //                 bottomLeft: Radius.circular(40),
                        //                 bottomRight: Radius.circular(40)),
                        //             gradient: LinearGradient(
                        //               colors: [

                        //                 Colors.purple,
                        //                 Colors.blue
                        //               ], // Set your gradient colors
                        //             ),
                        //           ),

                        //           child: Center(
                        //             child: FractionallySizedBox(
                        //                    heightFactor: 0.9, // Adjust those two for the white space
                        //                    widthFactor: 0.9,
                        //               child: Image.asset(
                        //                 'assets/images/profile.png', // Replace 'assets/images/profile.png' with your actual image asset path
                        //                 // width:
                        //                 //     80, // Set the width of the image inside the inner container
                        //                 // height:
                        //                 //     80, // Set the height of the image inside the inner container
                        //                 fit: BoxFit
                        //                     .contain, // Adjust the fit property as needed to fit the image within the inner container
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Container(
                                  // width:
                                  //     120, // Set the width of the outer container
                                  // height:
                                  //     120, // Set the height of the outer container
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Make the outer container circular
                                    gradient: LinearGradient(
                                      colors: const [
                                        Colors.purple,
                                        Colors.blue
                                      ], // Set your gradient colors
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image.network(
                                            controller
                                                .currentUser!.profileImageUrl!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(controller.currentUser!.name!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset('assets/images/verifiedicon.png')
                              ],
                            ),
                            Text(controller.currentUser!.categories!.join('& '),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.45),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.profile);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        90, // Set the width of the outer container
                                    height:
                                        90, // Set the height of the outer container
                                    decoration: BoxDecoration(
                                      shape: BoxShape
                                          .circle, // Make the outer container circular
                                      gradient: LinearGradient(
                                        colors: const [
                                          Colors.purple,
                                          Colors.blue
                                        ], // Set your gradient colors
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          2.0), // Add padding for space between the image and the border
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Make the inner container circular
                                          color: Colors.black,
                                          // Set the background color of the inner container
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              2.0), // Add padding for space between the inner container and the image
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/user.png', // Replace 'assets/images/profile.png' with your actual image asset path
                                              width:
                                                  80, // Set the width of the image inside the inner container
                                              height:
                                                  80, // Set the height of the image inside the inner container
                                              // fit: BoxFit
                                              //     .contain, // Adjust the fit property as needed to fit the image within the inner container
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Text("View Profile",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width:
                                      90, // Set the width of the outer container
                                  height:
                                      90, // Set the height of the outer container
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Make the outer container circular
                                    gradient: LinearGradient(
                                      colors: const [
                                        Colors.purple,
                                        Colors.blue
                                      ], // Set your gradient colors
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        2.0), // Add padding for space between the image and the border
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Make the inner container circular
                                        color: Colors.black,
                                        // Set the background color of the inner container
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            2.0), // Add padding for space between the inner container and the image
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/chats.png', // Replace 'assets/images/profile.png' with your actual image asset path
                                            width:
                                                80, // Set the width of the image inside the inner container
                                            height:
                                                80, // Set the height of the image inside the inner container
                                            // fit: BoxFit
                                            //     .contain, // Adjust the fit property as needed to fit the image within the inner container
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text("Chats",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width:
                                      90, // Set the width of the outer container
                                  height:
                                      90, // Set the height of the outer container
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Make the outer container circular
                                    gradient: LinearGradient(
                                      colors: const [
                                        Colors.purple,
                                        Colors.blue
                                      ], // Set your gradient colors
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        2.0), // Add padding for space between the image and the border
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Make the inner container circular
                                        color: Colors.black,
                                        // Set the background color of the inner container
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            2.0), // Add padding for space between the inner container and the image
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/orders.png', // Replace 'assets/images/profile.png' with your actual image asset path
                                            width:
                                                80, // Set the width of the image inside the inner container
                                            height:
                                                80, // Set the height of the image inside the inner container
                                            // fit: BoxFit
                                            //     .contain, // Adjust the fit property as needed to fit the image within the inner container
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text("Orders",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width:
                                      90, // Set the width of the outer container
                                  height:
                                      90, // Set the height of the outer container
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Make the outer container circular
                                    gradient: LinearGradient(
                                      colors: const [
                                        Colors.purple,
                                        Colors.blue
                                      ], // Set your gradient colors
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        2.0), // Add padding for space between the image and the border
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Make the inner container circular
                                        color: Colors.black,
                                        // Set the background color of the inner container
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            2.0), // Add padding for space between the inner container and the image
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/packeges.png', // Replace 'assets/images/profile.png' with your actual image asset path
                                            width:
                                                80, // Set the width of the image inside the inner container
                                            height:
                                                80, // Set the height of the image inside the inner container
                                            // fit: BoxFit
                                            //     .contain, // Adjust the fit property as needed to fit the image within the inner container
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text("Packages",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.offNamed(AppRoutes.editprofile);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        90, // Set the width of the outer container
                                    height:
                                        90, // Set the height of the outer container
                                    decoration: BoxDecoration(
                                      shape: BoxShape
                                          .circle, // Make the outer container circular
                                      gradient: LinearGradient(
                                        colors: const [
                                          Colors.purple,
                                          Colors.blue
                                        ], // Set your gradient colors
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          2.0), // Add padding for space between the image and the border
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Make the inner container circular
                                          color: Colors.black,
                                          // Set the background color of the inner container
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              2.0), // Add padding for space between the inner container and the image
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/editprofile.png', // Replace 'assets/images/profile.png' with your actual image asset path
                                              width:
                                                  80, // Set the width of the image inside the inner container
                                              height:
                                                  80, // Set the height of the image inside the inner container
                                              // fit: BoxFit
                                              //     .contain, // Adjust the fit property as needed to fit the image within the inner container
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text("Edit Profile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width:
                                      90, // Set the width of the outer container
                                  height:
                                      90, // Set the height of the outer container
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Make the outer container circular
                                    gradient: LinearGradient(
                                      colors: const [
                                        Colors.purple,
                                        Colors.blue
                                      ], // Set your gradient colors
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        2.0), // Add padding for space between the image and the border
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Make the inner container circular
                                        color: Colors.black,
                                        // Set the background color of the inner container
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            2.0), // Add padding for space between the inner container and the image
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/myevents.png', // Replace 'assets/images/profile.png' with your actual image asset path
                                            width:
                                                80, // Set the width of the image inside the inner container
                                            height:
                                                80, // Set the height of the image inside the inner container
                                            // fit: BoxFit
                                            //     .contain, // Adjust the fit property as needed to fit the image within the inner container
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text("My Events",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width:
                                      90, // Set the width of the outer container
                                  height:
                                      90, // Set the height of the outer container
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Make the outer container circular
                                    gradient: LinearGradient(
                                      colors: const [
                                        Colors.purple,
                                        Colors.blue
                                      ], // Set your gradient colors
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        2.0), // Add padding for space between the image and the border
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Make the inner container circular
                                        color: Colors.black,
                                        // Set the background color of the inner container
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            2.0), // Add padding for space between the inner container and the image
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/mysales.png', // Replace 'assets/images/profile.png' with your actual image asset path
                                            width:
                                                80, // Set the width of the image inside the inner container
                                            height:
                                                80, // Set the height of the image inside the inner container
                                            // fit: BoxFit
                                            //     .contain, // Adjust the fit property as needed to fit the image within the inner container
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text("My Sales",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text('data',style: TextStyle(color: Colors.amber),),
                  //   ],
                  // )
                ],
              ),
            )
          : BasicLoader(),
    );
  }
}
