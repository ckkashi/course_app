import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/screens/widgets/course_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecificCategoryCourses extends StatelessWidget {
  dynamic args;
  static const page_id = '/SpecificCategoryCourses';
  SpecificCategoryCourses({super.key, required this.args});

  final courseController = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args['category'].toString()),
      ),
      body: FutureBuilder(
          future: courseController.getSpecificCategoryCourses(args['category']),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data.length == 0) {
              return Center(
                child:
                    Text('No courses found of ${args['category']} category.'),
              );
            } else {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    dynamic keys = snapshot.data.keys.toList();
                    CourseModel courseData = snapshot.data[keys[index]];
                    print('data: ${courseData}');
                    return CourseContainer(courseData: courseData);
                  });
            }
          }),
    );
  }
}
