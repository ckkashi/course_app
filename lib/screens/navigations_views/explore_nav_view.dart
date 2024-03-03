import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/screens/courses_views/specific_cat_courses.dart';
import 'package:course_app/screens/widgets/course_container.dart';
import 'package:course_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExploreNavView extends StatelessWidget {
  ExploreNavView({super.key});

  final courseController = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courseController.courseCategories.length,
              itemBuilder: (context, index) {
                String catName = courseController.courseCategories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, SpecificCategoryCourses.page_id,
                          arguments: {'category': catName});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primary_color,
                          borderRadius: BorderRadius.circular(6.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 8.0),
                      child: Center(
                          child: Text(
                        catName,
                        style: const TextStyle(color: bg_color),
                      )),
                    ),
                  ),
                );
              },
            ),
          ),
          FutureBuilder(
              future: courseController.getAllCourses(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No courses found'),
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
        ],
      ),
    );
  }
}
