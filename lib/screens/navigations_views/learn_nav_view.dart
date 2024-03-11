import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/screens/courses_views/course_view.dart';
import 'package:course_app/screens/widgets/course_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearnNavView extends StatelessWidget {
  LearnNavView({super.key});

  var courseController = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
              future: courseController.getUserEnrolledCourses(),
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
                          child: Text('No enrolled courses found'),
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
                            CourseModel courseData = snapshot.data[keys[index]];
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
                                child: CourseContainer(courseData: courseData));
                          });
                }
              }),
        ],
      ),
    );
  }
}
