import 'package:course_app/models/course_model.dart';
import 'package:course_app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CourseContainer extends StatelessWidget {
  CourseModel courseData;
  CourseContainer({super.key, required this.courseData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 3)
            ]),
        child: Column(
          // mainAxisAlignment: MAin,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                courseData.thumbnail.toString(),
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 4),
              child: Text(
                courseData.title.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: primary_color, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1, left: 6),
              child: Text(
                'Category: ${courseData.category.toString()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.labelMedium!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1, left: 6),
              child: Text(
                'Level: ${courseData.level.toString()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.labelMedium!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1, left: 6),
              child: Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 14,
                  ),
                  Text(
                    ' ${courseData.likes.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.labelMedium!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
