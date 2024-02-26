import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  FirebaseStorage storageInstanceFirebase = FirebaseStorage.instance;

  TextEditingController courseTitle = TextEditingController();
  TextEditingController courseDescription = TextEditingController();
  TextEditingController skillsGain = TextEditingController();

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
  }

  List<Map> courseFilesList = [];
  List<String> courseFilesUrlList = [];

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
    return url;
  }

  upload() async {
    if (_courseVideo.isEmpty &&
        _courseFile.isEmpty &&
        _courseThumbnail.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Select all files',
      ));
    } else {
      courseFilesList.add(_courseVideo.value);
      courseFilesList.add(_courseThumbnail.value);
      courseFilesList.add(_courseFile.value);
      await Future.wait(courseFilesList.map((_image) async {
        var url = await uploadFile(
            _image['filePath'], _image['fileName'], _image['fileType']);
        courseFilesUrlList.add(url.toString());
        return url;
      }));
      clearSelectedData();
      print(courseFilesUrlList);
    }
  }
}
