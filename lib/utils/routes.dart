import 'package:course_app/models/course_model.dart';
import 'package:course_app/screens/auth_views/edit_profile_view.dart';
import 'package:course_app/screens/courses_views/course_view.dart';
import 'package:course_app/screens/courses_views/specific_cat_courses.dart';
import 'package:course_app/screens/home_screen.dart';
import 'package:course_app/screens/my_courses_views/add_course_view.dart';
import 'package:course_app/screens/my_courses_views/my_course_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case HomeScreen.page_id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case EditProfileView.page_id:
        return MaterialPageRoute(builder: (_) => EditProfileView());
      case MyCourseView.page_id:
        return MaterialPageRoute(builder: (_) => MyCourseView());
      case AddCourseView.page_id:
        return MaterialPageRoute(builder: (_) => AddCourseView());
      case SpecificCategoryCourses.page_id:
        return MaterialPageRoute(
            builder: (_) => SpecificCategoryCourses(
                  args: args,
                ));
      case CourseView.page_id:
        return MaterialPageRoute(
            builder: (_) => CourseView(
                  args: args,
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('Undefined routes'),
                  ),
                ));
    }
  }
}
