import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/screens/auth_views/edit_profile_view.dart';
import 'package:course_app/screens/my_courses_views/my_course_view.dart';
import 'package:course_app/screens/widgets/profile_tab.dart';
import 'package:course_app/screens/widgets/round_button.dart';
import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final firebase_controller = Get.find<FirebaseController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Text(firebase_controller.getUserData.username!
                    .toString()
                    .toUpperCase()),
                subtitle:
                    Text(firebase_controller.getUserData.email!.toString()),
              ),
              ProfileTab(
                  title: edit_profile_string,
                  icon: Icons.edit,
                  onTap: () {
                    Get.toNamed(EditProfileView.page_id);
                  }),
              ProfileTab(
                  title: my_courses_string,
                  icon: Icons.book,
                  onTap: () {
                    // Get.to(() => const MyCourseView(),
                    //     transition: Transition.circularReveal,
                    //     );
                    Get.toNamed(
                      MyCourseView.page_id,
                    );
                  }),
              ProfileTab(
                  title: logout_string,
                  icon: Icons.logout,
                  onTap: () {
                    firebase_controller.signout();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
