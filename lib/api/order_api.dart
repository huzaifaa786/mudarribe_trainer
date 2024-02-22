// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mudarribe_trainer/models/app_user.dart';
// import 'package:mudarribe_trainer/models/combine_order.dart';
// import 'package:mudarribe_trainer/models/order.dart';
// import 'package:mudarribe_trainer/models/packages.dart';
// import 'package:mudarribe_trainer/models/personal_plan.dart';
// import 'package:mudarribe_trainer/models/trainee_profile.dart';

// class OrderApi {
//   static Future<List<CombinedOrderData>> fetchTrainerOrders() async {
//     final trainerId = FirebaseAuth.instance.currentUser!.uid;
//     List<CombinedOrderData> combineOrders = [];
//     QuerySnapshot orders = await FirebaseFirestore.instance
//         .collection('orders')
//         .where("trainerId", isEqualTo: trainerId).orderBy('orderId',descending: true)
//         .get();
//     print(orders);
//     for (var orderDoc in orders.docs) {

//       if (orderDoc.exists) {
//         Map<String, dynamic> orderData =
//             orderDoc.data()! as Map<String, dynamic>;

//         TrainerOrder order = TrainerOrder.fromJson(orderData);

//         DocumentSnapshot trainerSnapshot = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(order.trainerId)
//             .get();

//         Map<String, dynamic> trainerData =
//             trainerSnapshot.data()! as Map<String, dynamic>;
//         AppUser trainer = AppUser.fromJson(trainerData);

//         DocumentSnapshot traineeSnapshot = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(order.userId)
//             .get();

//         Map<String, dynamic> traineeData =
//             traineeSnapshot.data()! as Map<String, dynamic>;
//         TraineeProfile trainee = TraineeProfile.fromJson(traineeData);
//         print(trainee);
//         print(trainer);
//         print(order);
//         if (order.type == 'My_Plan') {
//           DocumentSnapshot personalPlanSnapshot = await FirebaseFirestore
//               .instance
//               .collection('personalplans')
//               .doc(order.planId)
//               .get();

//           Map<String, dynamic> personalPlanData =
//               personalPlanSnapshot.data()! as Map<String, dynamic>;

//           PersonalPlan personalPlan = PersonalPlan.fromJson(personalPlanData);
//           combineOrders.add(CombinedOrderData(
//               trainer: trainer,
//               trainee: trainee,
//               order: order,
//               personalPlan: personalPlan));
//         } else {
//           DocumentSnapshot pacakageSnapshot = await FirebaseFirestore.instance
//               .collection('packages')
//               .doc(order.planId)
//               .get();

//           Map<String, dynamic> pacakageData =
//               pacakageSnapshot.data()! as Map<String, dynamic>;

//           Package package = Package.fromJson(pacakageData);
//           combineOrders.add(CombinedOrderData(
//               trainer: trainer,
//               trainee: trainee,
//               order: order,
//               package: package));
//         }
//       }
//     }

//     return combineOrders;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/combine_order.dart';
import 'package:mudarribe_trainer/models/order.dart';
import 'package:mudarribe_trainer/models/packages.dart';
import 'package:mudarribe_trainer/models/personal_plan.dart';
import 'package:mudarribe_trainer/models/trainee_profile.dart';

class OrderApi {
  static Future<List<CombinedOrderData>> fetchTrainerOrders(
      {DocumentSnapshot? lastDocument}) async {
    final trainerId = FirebaseAuth.instance.currentUser!.uid;
    List<CombinedOrderData> combinedOrders = [];

    Query ordersQuery = FirebaseFirestore.instance
        .collection('orders')
        .where("trainerId", isEqualTo: trainerId)
        .orderBy('orderId', descending: true);

    if (lastDocument != null) {
      ordersQuery = ordersQuery.startAfterDocument(lastDocument);
    }

    QuerySnapshot orders = await ordersQuery.limit(4).get();

    var futures = orders.docs.map((orderDoc) async {
      if (orderDoc.exists) {
        Map<String, dynamic> orderData =
            orderDoc.data()! as Map<String, dynamic>;
        TrainerOrder order = TrainerOrder.fromJson(orderData);

        var [trainerSnapshot, traineeSnapshot] = await Future.wait([
          FirebaseFirestore.instance
              .collection('users')
              .doc(order.trainerId)
              .get(),
          FirebaseFirestore.instance
              .collection('users')
              .doc(order.userId)
              .get(),
        ]);

        Map<String, dynamic> trainerData = trainerSnapshot.data()!;
        AppUser trainer = AppUser.fromJson(trainerData);

        Map<String, dynamic> traineeData = traineeSnapshot.data()!;
        TraineeProfile trainee = TraineeProfile.fromJson(traineeData);

        if (order.type == 'My_Plan') {
          DocumentSnapshot personalPlanSnapshot = await FirebaseFirestore
              .instance
              .collection('personalplans')
              .doc(order.planId)
              .get();

          Map<String, dynamic> personalPlanData =
              personalPlanSnapshot.data()! as Map<String, dynamic>;
          PersonalPlan personalPlan = PersonalPlan.fromJson(personalPlanData);

          combinedOrders.add(CombinedOrderData(
            trainer: trainer,
            trainee: trainee,
            order: order,
            personalPlan: personalPlan,
            lastdoc: orderDoc,
          ));
        } else {
          DocumentSnapshot packageSnapshot = await FirebaseFirestore.instance
              .collection('packages')
              .doc(order.planId)
              .get();

          Map<String, dynamic> packageData =
              packageSnapshot.data()! as Map<String, dynamic>;
          Package package = Package.fromJson(packageData);

          combinedOrders.add(CombinedOrderData(
            trainer: trainer,
            trainee: trainee,
            order: order,
            package: package,
            lastdoc: orderDoc,
          ));
        }
      }
    });
    await Future.wait(futures);
    return combinedOrders;
  }
}
