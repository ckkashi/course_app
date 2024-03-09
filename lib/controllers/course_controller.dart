// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  FirebaseStorage storageInstanceFirebase = FirebaseStorage.instance;
  FirebaseFirestore firestoreInstanceFirebase = FirebaseFirestore.instance;
  final fbController = Get.find<FirebaseController>();
  var courseCollection = FirebaseFirestore.instance.collection('courses');

  TextEditingController courseTitle = TextEditingController();
  TextEditingController courseDescription = TextEditingController();
  TextEditingController skillsGain = TextEditingController();
  TextEditingController courseCategory = TextEditingController(text: 'Flutter');
  TextEditingController courseLanguage = TextEditingController(text: 'English');
  TextEditingController courseLevel = TextEditingController(text: 'Beginner');

  List<String> _courseCategories = [
    'Flutter',
    'Data Science',
    'Android',
    'IOS',
    'Data Analytics'
  ];
  List<String> get courseCategories => _courseCategories;
  List<String> _courseLanguages = ['English', 'Urdu'];
  List<String> get courseLanguages => _courseLanguages;
  List<String> _courseLevels = ['Beginner', 'Intermediate', 'Advanced'];
  List<String> get courseLevels => _courseLevels;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   getAllCourses();
  // }

  final _courseVideo = {}.obs;
  get courseVideo => _courseVideo.value;
  setCourseVideo(Map<String, dynamic> value) {
    _courseVideo(value);
  }

  final _courseFile = {}.obs;
  get courseFile => _courseFile.value;
  setCourseFile(Map<String, dynamic> value) {
    _courseFile(value);
  }

  final _courseThumbnail = {}.obs;
  get courseThumbnail => _courseThumbnail.value;
  setCourseThumbnail(Map<String, dynamic> value) {
    _courseThumbnail(value);
  }

  clearSelectedData() {
    _courseFile.clear();
    _courseThumbnail.clear();
    _courseVideo.clear();
    courseTitle.text = '';
    courseDescription.text = '';
    skillsGain.text = '';
    update();
  }

  List<Map> courseFilesList = [];
  List<String> courseFilesUrlList = [];
  Map<String, dynamic> courseFilesUrl = {
    "videoUrl": "",
    "thumbnailUrl": "",
    "fileUrl": "",
  };

  filePicker(String type) async {
    FilePickerResult? result;
    PlatformFile? pickedFile;
    String? fileName;
    try {
      if (type == "video") {
        result = await FilePicker.platform
            .pickFiles(type: FileType.video, allowMultiple: false);
      } else if (type == "file") {
        result = await FilePicker.platform
            .pickFiles(type: FileType.any, allowMultiple: false);
      } else if (type == "thumbnail") {
        result = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: false);
      }

      if (result != null) {
        pickedFile = result.files.first;
        fileName = pickedFile.name;
        if (kDebugMode) {
          print(pickedFile.path);
          print(fileName);
        }
      }
      if (type == "video") {
        final value = {
          "fileName": fileName.toString(),
          "filePath": pickedFile!.path.toString(),
          "fileType": type
        };
        setCourseVideo(value);
      } else if (type == "file") {
        final value = {
          "fileName": fileName.toString(),
          "filePath": pickedFile!.path.toString(),
          "fileType": type
        };
        setCourseFile(value);
      } else if (type == "thumbnail") {
        final value = {
          "fileName": fileName.toString(),
          "filePath": pickedFile!.path.toString(),
          "fileType": type
        };
        setCourseThumbnail(value);
      }
      update();
      return {
        "fileName": fileName.toString(),
        "filePath": pickedFile!.path.toString(),
        "fileType": type
      };
    } catch (e) {
      log(e.toString());
    }
  }

  uploadFile(String filePath, String fileName, String type) async {
    UploadTask? uploadTask;
    String? path;
    if (type == "video") {
      path = 'courseVideos/$fileName';
    } else if (type == "file") {
      path = 'courseFiles/$fileName';
    } else {
      path = 'courseThumbnail/$fileName';
    }

    final file = File(filePath);
    final ref = storageInstanceFirebase.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();
    if (type == "video") {
      courseFilesUrl['videoUrl'] = url;
    } else if (type == "file") {
      courseFilesUrl['fileUrl'] = url;
    } else {
      courseFilesUrl['thumbnailUrl'] = url;
    }
    return url;
  }

  final _courseUploadLoading = false.obs;
  get courseUploadLoading => _courseUploadLoading.value;
  upload(BuildContext context) async {
    if (_courseVideo.isEmpty ||
        _courseFile.isEmpty ||
        _courseThumbnail.isEmpty ||
        courseCategory.text.isEmpty ||
        courseTitle.text.isEmpty ||
        courseDescription.text.isEmpty ||
        skillsGain.text.isEmpty ||
        courseLevel.text.isEmpty ||
        courseLanguage.text.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Select all files and fill all the fields')));
      Utils.showSnackBar(
          context, 'Select all files and fill all the fields', error_color);
    } else {
      _courseUploadLoading(true);
      update();
      courseFilesList.add(_courseVideo.value);
      courseFilesList.add(_courseThumbnail.value);
      courseFilesList.add(_courseFile.value);
      await Future.wait(courseFilesList.map((_image) async {
        await uploadFile(
            _image['filePath'], _image['fileName'], _image['fileType']);
      }));

      CourseModel courseData = CourseModel(
          title: courseTitle.text,
          description: courseDescription.text,
          skillGain: skillsGain.text,
          category: courseCategory.text,
          level: courseLevel.text,
          language: courseLanguage.text,
          files: [courseFilesUrl['fileUrl']],
          videos: [courseFilesUrl['videoUrl']],
          thumbnail: courseFilesUrl['thumbnailUrl'],
          likes: 0,
          approved: "false",
          addedat: DateTime.now().toString(),
          addedby: fbController.getUserData.uid.toString(),
          updatedat: "");
      print(courseData.toJson());
      await firestoreInstanceFirebase
          .collection('courses')
          .add(courseData.toJson());
      clearSelectedData();
      _courseUploadLoading(false);
      update();
      Navigator.pop(context);
      Utils.showSnackBar(
          context, 'Course uploaded successfully', primary_color);
    }
  }

  Map<String, dynamic> coursesList = {};
  Map<String, dynamic> likedCoursesList = {};

  Map<String, dynamic> userUploadedCoursesList = {};

  getAllCourses() async {
    try {
      QuerySnapshot courses = await courseCollection.get();
      for (var currentCourse in courses.docs) {
        coursesList[currentCourse.id] =
            CourseModel.fromJson(currentCourse.data() as Map<String, dynamic>);
      }
      print(coursesList);
      return coursesList;
    } catch (e) {
      print(e);
    }
  }

  getMostLikedCourses() async {
    try {
      QuerySnapshot courses = await courseCollection
          .orderBy("likes", descending: true)
          .where("likes", isNotEqualTo: 0)
          .limit(3)
          .get();
      for (var currentCourse in courses.docs) {
        likedCoursesList[currentCourse.id] =
            CourseModel.fromJson(currentCourse.data() as Map<String, dynamic>);
      }
      print(likedCoursesList);
      return likedCoursesList;
    } catch (e) {
      print(e);
    }
  }

  getUserUploadedCourses() async {
    try {
      QuerySnapshot courses = await courseCollection
          .where("addedby", isEqualTo: fbController.getUserData.uid)
          .get();
      for (var currentCourse in courses.docs) {
        userUploadedCoursesList[currentCourse.id] =
            CourseModel.fromJson(currentCourse.data() as Map<String, dynamic>);
      }
      print(userUploadedCoursesList);
      return userUploadedCoursesList;
    } catch (e) {
      print(e);
    }
  }

  getSpecificCategoryCourses(String catName) async {
    Map<String, dynamic> specificCourses = {};
    try {
      QuerySnapshot courses =
          await courseCollection.where("category", isEqualTo: catName).get();
      for (var currentCourse in courses.docs) {
        specificCourses[currentCourse.id] =
            CourseModel.fromJson(currentCourse.data() as Map<String, dynamic>);
      }
      print(specificCourses);
      return specificCourses;
    } catch (e) {
      print(e);
    }
  }

  enrollCourse(BuildContext context, String courseId) async {
    String userId = fbController.getUserData.uid.toString();
    await firestoreInstanceFirebase.collection('users').doc(userId).update({
      "courses": FieldValue.arrayUnion([courseId])
    });
    fbController.userData.courses!.add(courseId);
    fbController.update();
    Navigator.of(context);
    Utils.showSnackBar(context, 'Course enrolled successfully', primary_color);
  }

  getUserEnrolledCourses() async {
    Map<String, dynamic> userEnrolledCoursesList = {};
    final enrolledCoursesList = fbController.getUserData.courses;
    final keys = coursesList.keys.toList();
    for (var courseId in enrolledCoursesList!) {
      if (keys.contains(courseId)) {
        userEnrolledCoursesList[courseId] = coursesList[courseId];
      }
    }
    return userEnrolledCoursesList;
  }

  bool checkUserEnrolled(String courseId) {
    bool exist = false;
    print(courseId);
    var enrolledCoursesList = fbController.getUserData.courses;
    if (enrolledCoursesList == null || enrolledCoursesList == []) {
      exist = false;
    } else {
      exist = enrolledCoursesList.contains(courseId);
    }
    return exist;
  }

  Future<UserModel> getUploadedCourseUser(String userId) async {
    DocumentSnapshot userSnap =
        await firestoreInstanceFirebase.collection('users').doc(userId).get();
    UserModel findUser =
        UserModel.fromJson(userSnap.data() as Map<String, dynamic>);
    print(findUser);
    return findUser;
  }

  getUserLikeCourses() async {
    Map<String, dynamic> userLikedCoursesList = {};
    final likedCoursesList = fbController.getUserData.like_courses;
    final keys = coursesList.keys.toList();
    for (var courseId in likedCoursesList!) {
      if (keys.contains(courseId)) {
        userLikedCoursesList[courseId] = coursesList[courseId];
      }
    }
    return userLikedCoursesList;
  }

  applyCourseLike(BuildContext context, String courseId) async {
    if (checkUserLiked(courseId)) {
      dislikeCourse(context, courseId);
    } else {
      likeCourse(context, courseId);
    }
  }

  likeCourse(BuildContext context, String courseId) async {
    String userId = fbController.getUserData.uid.toString();
    await firestoreInstanceFirebase.collection('users').doc(userId).update({
      "like_courses": FieldValue.arrayUnion([courseId])
    });
    DocumentSnapshot current_course_snap =
        await courseCollection.doc(courseId).get();
    await firestoreInstanceFirebase
        .collection('courses')
        .doc(courseId)
        .update({"likes": current_course_snap['likes'] + 1});
    fbController.userData.like_courses!.add(courseId);
    fbController.update();
    Navigator.of(context);
    Navigator.of(context);
    Utils.showSnackBar(context, 'You liked that course', primary_color);
  }

  dislikeCourse(BuildContext context, String courseId) async {
    String userId = fbController.getUserData.uid.toString();
    await firestoreInstanceFirebase.collection('users').doc(userId).update({
      "like_courses": FieldValue.arrayRemove([courseId])
    });
    DocumentSnapshot current_course_snap =
        await courseCollection.doc(courseId).get();
    await firestoreInstanceFirebase
        .collection('courses')
        .doc(courseId)
        .update({"likes": current_course_snap['likes'] - 1});
    fbController.userData.like_courses!.remove(courseId);
    fbController.update();
    Navigator.of(context);
    Utils.showSnackBar(context, 'You disliked that course', error_color);
    Navigator.of(context);
  }

  bool checkUserLiked(String courseId) {
    bool liked = false;
    print(courseId);
    var likedCoursesList = fbController.getUserData.like_courses;
    if (likedCoursesList == null || likedCoursesList == []) {
      liked = false;
    } else {
      liked = likedCoursesList.contains(courseId);
    }
    return liked;
  }

  clearUserData() {
    userUploadedCoursesList.clear();
  }
}
