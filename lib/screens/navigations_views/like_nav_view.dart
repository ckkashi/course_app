import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/screens/courses_views/course_view.dart';
import 'package:course_app/screens/widgets/course_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeNavView extends StatelessWidget {
  LikeNavView({super.key});

  var courseController = Get.find<CourseController>();
  var fbController = Get.find<FirebaseController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          fbController.getUserData == null
              ? Center(
                  child: Text('user not loggedin'),
                )
              : FutureBuilder(
                  future: courseController.getUserLikeCourses(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('user not loggedin'),
                      );
                    } else {
                      return snapshot.data.length == 0
                          ? Center(
                              child: Text('No liked courses found'),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 210,
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                dynamic keys = snapshot.data.keys.toList();
                                CourseModel courseData =
                                    snapshot.data[keys[index]];
                                print('data: ${courseData}');
                                return GestureDetector(
                                    onTap: () {
                                      dynamic args = {
                                        "courseData": courseData,
                                        "courseId": keys[index]
                                      };
                                      Navigator.pushNamed(
                                          context, CourseView.page_id,
                                          arguments: args);
                                    },
                                    child: CourseContainer(
                                        courseData: courseData));
                              });
                    }
                  }),
        ],
      ),
    );
  }
}
