import 'package:course_app/screens/my_courses_views/add_course_view.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCourseView extends StatelessWidget {
  static const page_id = '/MyCourseView';
  const MyCourseView({super.key});

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
      body: Center(
        child: Text('My CourseView'),
      ),
    );
  }
}
