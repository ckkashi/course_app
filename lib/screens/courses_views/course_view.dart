import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/course_view_controller.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/screens/widgets/round_button.dart';
import 'package:course_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CourseView extends StatefulWidget {
  static const page_id = '/CourseView';
  final args;
  CourseView({super.key, required this.args});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  var courseController = Get.find<CourseController>();

  var courseViewController = Get.put(CourseViewController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    courseViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetBuilder(
        init: courseController,
        builder: (controller) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: primary_color,
              ),
            ),
            bottomNavigationBar:
                controller.checkUserEnrolled(widget.args['courseId'])
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundButton(
                            title: 'Enroll', onPressed: () {}, loading: false),
                      ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.args['courseData'].thumbnail.toString(),
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Text(
                      widget.args['courseData'].title.toString(),
                      style: textTheme.titleLarge!.copyWith(
                          color: primary_color, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Heading('Video', textTheme),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: FutureBuilder(
                      future: courseViewController
                          .init(widget.args['courseData'].videos[0]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return Column(
                          children: [
                            AspectRatio(
                              aspectRatio: courseViewController
                                  .controller.value.aspectRatio,
                              // Use the VideoPlayer widget to display the video.
                              child:
                                  VideoPlayer(courseViewController.controller),
                            ),
                            Container(
                              height: 50,
                              color: Colors.black,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        courseViewController.controller.play();
                                        courseViewController.update();
                                      },
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        courseViewController.controller.pause();
                                        courseViewController.update();
                                      },
                                      icon: Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Heading('Description', textTheme),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.args['courseData'].description.toString(),
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  Heading('Skills gain', textTheme),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.args['courseData'].skillGain.toString(),
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  Heading('Category', textTheme),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.args['courseData'].category.toString(),
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  Heading('Language', textTheme),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.args['courseData'].language.toString(),
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  Heading('Level', textTheme),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.args['courseData'].level.toString(),
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  Heading('Course by', textTheme),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: FutureBuilder(
                      future: courseController.getUploadedCourseUser(
                          widget.args['courseData'].addedby.toString()),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(
                            color: primary_color,
                          );
                        }
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data.username.toString()),
                            subtitle: Text(snapshot.data.bio.toString()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Padding Heading(String text, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5),
      child: Text(
        text,
        style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
