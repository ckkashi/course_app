import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/screens/auth_views/login_view.dart';
import 'package:course_app/screens/auth_views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountNavView extends StatelessWidget {
  const AccountNavView({super.key});

  @override
  Widget build(BuildContext context) {
    var keyOne = GlobalKey<NavigatorState>();
    return Consumer<FirebaseController>(builder: (context, value, _) {
      return value.loggedinUser() != null
          ? const ProfileView()
          : WillPopScope(
              onWillPop: () async => !await keyOne.currentState!.maybePop(),
              child: Navigator(
                key: keyOne,
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  );
                },
              ),
            );
    });
  }
}
