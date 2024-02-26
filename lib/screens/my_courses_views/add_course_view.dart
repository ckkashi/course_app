import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/screens/widgets/round_button.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCourseView extends StatelessWidget {
  static const page_id = '/AddCourseView';
  AddCourseView({super.key});

  final courseController = Get.find<CourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(add_course_string),
      ),
      body: SafeArea(
        child: GetBuilder<CourseController>(builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(courseController.courseVideo.isEmpty
                          ? 'Select Course Video'
                          : '${courseController.courseVideo['fileName']}'),
                    ),
                    Flexible(
                      child: ElevatedButton(
                          onPressed: () async {
                            await courseController.filePicker("video");
                          },
                          child: Icon(Icons.video_file_outlined)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(courseController.courseFile.isEmpty
                          ? 'Select Course File'
                          : '${courseController.courseFile['fileName']}'),
                    ),
                    Flexible(
                      child: ElevatedButton(
                          onPressed: () async {
                            await courseController.filePicker("file");
                          },
                          child: Icon(Icons.file_copy_outlined)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(courseController.courseThumbnail.isEmpty
                          ? 'Select Course Thumbnail'
                          : '${courseController.courseThumbnail['fileName']}'),
                    ),
                    Flexible(
                      child: ElevatedButton(
                          onPressed: () async {
                            await courseController.filePicker("thumbnail");
                          },
                          child: Icon(Icons.image_outlined)),
                    ),
                  ],
                ),
                RoundButton(
                    title: 'Upload',
                    onPressed: () async {
                      await courseController.upload();
                    },
                    loading: false),
              ],
            ),
          );
        }),
      ),
    );
  }
}
