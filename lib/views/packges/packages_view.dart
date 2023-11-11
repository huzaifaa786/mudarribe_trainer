import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mudarribe_trainer/components/packagebox.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/nevigate.svg',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Packages',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: 30),
               PackageCard(),
                SizedBox(height: 30),
                  PackageCard(),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Container(
                      width: 90, // Set the width of the outer container
                      height: 90, // Set the height of the outer container
                      decoration: BoxDecoration(
                        shape: BoxShape
                            .circle, // Make the outer container circular
                        gradient: LinearGradient(
                          colors: [
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
                                'assets/images/add.png', // Replace 'assets/images/profile.png' with your actual image asset path
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
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/images/addnewpackegs.png'),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
