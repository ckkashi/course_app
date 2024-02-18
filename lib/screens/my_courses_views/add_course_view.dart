import 'package:course_app/utils/strings.dart';
import 'package:flutter/material.dart';

class AddCourseView extends StatelessWidget {
  static const page_id = '/AddCourseView';
  const AddCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(add_course_string),
        ),
        body: Center(
          child: Text('add CourseView'),
        ),
      ),
    );
  }
}
