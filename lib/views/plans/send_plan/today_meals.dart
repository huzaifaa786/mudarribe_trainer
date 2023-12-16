// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mudarribe_trainer/components/icon_button.dart';
// import 'package:mudarribe_trainer/components/meals_card.dart';
// import 'package:mudarribe_trainer/components/topbar.dart';
// import 'package:mudarribe_trainer/values/color.dart';

// class TodayMealsScreen extends StatefulWidget {
//   const TodayMealsScreen({super.key});

//   @override
//   State<TodayMealsScreen> createState() => _TodayMealsScreenState();
// }

// class _TodayMealsScreenState extends State<TodayMealsScreen> {
//   String title = '02';
//   String description = 'Full Body Energy';
//   String imgpath1 = 'assets/images/containimg.jpeg';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//           child: Column(
//         children: [
//           const TopBar(
//             text: 'Today Meals',
//           ),

//           Flexible(
//             flex: 1,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.9,
//               padding: const EdgeInsets.only(right: 15, left: 15, top: 45),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     IconButtons(title: 'Upload New Files', onPressed: () {}),
//                     Container(
//                       margin: const EdgeInsets.only(top: 15),
//                       padding: const EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                           color: const Color(0x872C2723),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Row(
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width * 0.17,
//                                 height:70,
                                    
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(60),
//                                     gradient: const LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                       colors: [
//                                         Color(0xff727dcd),
//                                         Color(0xff58e0ff)
//                                       ],
//                                     )),
//                                 child:
//                                     Image.asset('assets/images/dieticon.png'),
//                               ),
//                             ],
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Full Diet plan',
//                                     style: TextStyle(
//                                       color: white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                     )),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text('305 kb',
//                                     style: TextStyle(
//                                       color: white,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w600,
//                                     ))
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 135, bottom: 35),
//                             child: SvgPicture.asset('assets/images/delete.svg'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     MealsCard(
//                       title: title,
//                       description: description,
//                       imgpath1: imgpath1,
//                     ),
//                     MealsCard(
//                       title: title,
//                       description: description,
//                       imgpath1: imgpath1,
//                     ),
//                     MealsCard(
//                       title: title,
//                       description: description,
//                       imgpath1: imgpath1,
//                     ),
//                     MealsCard(
//                       title: title,
//                       description: description,
//                       imgpath1: imgpath1,
//                     ),
//                     const SizedBox(height: 20)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: IconButtons(
//                 onPressed: () {},
//                 title: 'Send Plan',
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       )),
//     );
//   }
// }
