// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/screens/widgets/form_field.dart';
import 'package:course_app/screens/widgets/form_text_area.dart';
import 'package:course_app/screens/widgets/round_button.dart';
import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileView extends StatelessWidget {
  static const page_id = '/EditProfileView';
  EditProfileView({super.key});

  final fbController = Get.find<FirebaseController>();

  UserModel? userData;

  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  FocusNode bioFocus = FocusNode();
  String photo =
      'https://static.vecteezy.com/system/resources/previews/016/808/173/original/camera-not-allowed-no-photography-image-not-available-concept-icon-in-line-style-design-isolated-on-white-background-editable-stroke-vector.jpg';

  @override
  Widget build(BuildContext context) {
    userData = fbController.getUserData;
    usernameController.text = userData!.username.toString();
    bioController.text =
        userData!.bio.toString() != 'null' ? userData!.bio.toString() : '';
    photo = userData!.photo.toString() != 'null'
        ? userData!.photo.toString()
        : photo;
    return GetBuilder(
        init: fbController,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(edit_profile_string),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (fbController.pickedProfile == null)
                      GestureDetector(
                        onTap: () {
                          controller.profilePicker();
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: primary_color,
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: primary_color,
                            backgroundImage: NetworkImage(photo),
                          ),
                        ),
                      ),
                    if (fbController.pickedProfile != null)
                      GestureDetector(
                        onTap: () {
                          controller.profilePicker();
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: primary_color,
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: primary_color,
                            backgroundImage: FileImage(File(
                                fbController.pickedProfile!.path.toString())),
                          ),
                        ),
                      ),
                    if (fbController.pickedProfile != null)
                      TextButton(
                          onPressed: () {
                            fbController.clearPicture();
                          },
                          child: Text('clear selected profile')),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FormTextField(
                      emailController: usernameController,
                      emailFocus: usernameFocus,
                      name: 'Username',
                      password: false,
                    ),
                    FormTextArea(
                        title: 'Bio',
                        controller: bioController,
                        focus: bioFocus),
                    const SizedBox(
                      height: 8.0,
                    ),
                    RoundButton(
                        title: edit_profile_string,
                        onPressed: () {
                          controller.updateUserProfile(usernameController.text,
                              bioController.text, context);
                        },
                        loading: controller.editProfileLoading),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
