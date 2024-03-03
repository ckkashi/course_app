import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/screens/widgets/form_field.dart';
import 'package:course_app/screens/widgets/form_text_area.dart';
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
        child: GetBuilder<CourseController>(builder: (controller) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormTextField(
                      emailController: controller.courseTitle,
                      emailFocus: FocusNode(),
                      name: 'Title',
                      password: false),
                  FormTextArea(
                      controller: controller.courseDescription,
                      focus: FocusNode(),
                      title: 'Description'),
                  FormTextArea(
                      controller: controller.skillsGain,
                      focus: FocusNode(),
                      title: 'Skills Gain'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          label: Text('Category')),
                      isExpanded: true,
                      value: controller.courseCategory.text,
                      items: controller.courseCategories.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.courseCategory.text = value.toString();
                        controller.update();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          label: Text('Level')),
                      isExpanded: true,
                      value: controller.courseLevel.text,
                      items: controller.courseLevels.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.courseLevel.text = value.toString();
                        controller.update();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          label: Text('Language')),
                      isExpanded: true,
                      value: controller.courseLanguage.text,
                      items: controller.courseLanguages.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.courseLanguage.text = value.toString();
                        controller.update();
                      },
                    ),
                  ),
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
                        await courseController.upload(context);
                      },
                      loading: controller.courseUploadLoading),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
