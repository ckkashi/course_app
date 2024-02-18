// ignore_for_file: non_constant_identifier_names

import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/screens/auth_views/login_view.dart';
import 'package:course_app/screens/auth_views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountNavView extends StatelessWidget {
  AccountNavView({super.key});
  final firebase_controller = Get.find<FirebaseController>();
  @override
  Widget build(BuildContext context) {
    var keyOne = GlobalKey<NavigatorState>();
    return GetBuilder(
        init: firebase_controller,
        builder: (controller) {
          return Container(
            child: controller.loggedinUser() != null
                ? ProfileView()
                : WillPopScope(
                    onWillPop: () async =>
                        !await keyOne.currentState!.maybePop(),
                    child: Navigator(
                      key: keyOne,
                      onGenerateRoute: (routeSettings) {
                        return MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        );
                      },
                    ),
                  ),
          );
        });
  }
}
