import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/screens/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(builder: (context, value, _) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: 'Logout',
                  onPressed: () {
                    value.signout();
                  },
                  loading: false)
            ],
          ),
        ),
      );
    });
  }
}
