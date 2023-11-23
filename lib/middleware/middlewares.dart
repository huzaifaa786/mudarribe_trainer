import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings redirect(String? route) {
    final User? user = FirebaseAuth.instance.currentUser;

    return user!.uid.isEmpty
        ? const RouteSettings(name: AppRoutes.signin)
        : RouteSettings(name: route);
  }
}
