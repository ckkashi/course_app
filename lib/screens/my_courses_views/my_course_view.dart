import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/screens/my_courses_views/add_course_view.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCourseView extends StatelessWidget {
  static const page_id = '/MyCourseView';
  MyCourseView({super.key});
  final courseController = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(my_courses_string),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AddCourseView.page_id);
              },
              icon: const Icon(Icons.add_rounded))
        ],
      ),
      body: FutureBuilder(
          future: courseController.getUserUploadedCourses(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data.length == 0) {
              return const Center(
                child: Text('No courses found'),
              );
            } else {
              return const Center(
                child: Text('My Courses view'),
              );
            }
          }),
    );
  }
}
