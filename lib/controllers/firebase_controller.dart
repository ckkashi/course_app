// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:course_app/models/user_model.dart';

import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseController extends GetxController {
  FirebaseAuth authInstanceFirebase = FirebaseAuth.instance;
  FirebaseFirestore storeInstanceFirebase = FirebaseFirestore.instance;
  FirebaseStorage storageInstanceFirebase = FirebaseStorage.instance;

  CollectionReference? userStoreCollection;
  @override
  void onInit() async {
    userStoreCollection = storeInstanceFirebase.collection('users');
    loggedinUser();
    super.onInit();
  }

  final _getDataLoading = false.obs;
  bool get getDataLoading => (_getDataLoading.value);
  toggleGetDataLoading() {
    _getDataLoading(!_getDataLoading.value);
    update();
  }

  var _user;
  User get getUser => _user;
  UserModel userData = UserModel();
  UserModel get getUserData => userData;
  loggedinUser() {
    // toggleGetDataLoading();
    if (_user == null) {
      authInstanceFirebase.idTokenChanges().listen((User? us) async {
        if (us != null) {
          _user = us;
          log(us.uid.toString());
          userData = await getUserCollectionData(us.uid.toString());
          print(userData.bio);
          update();
        }
      });
    }
    // toggleGetDataLoading();
    return _user;
  }

  signout() async {
    await authInstanceFirebase.signOut();
    _user = authInstanceFirebase.currentUser;
    userData = UserModel();
    update();
  }

  final _loginLoading = false.obs;
  bool get loginLoading => (_loginLoading.value);
  toggleLoginLoading() {
    _loginLoading(!_loginLoading.value);
    update();
  }

  final _registerLoading = false.obs;
  bool get registerLoading => (_registerLoading.value);
  toggleRegisterLoading() {
    _registerLoading(!_registerLoading.value);
    update();
  }

  createAccount(String username, String email, String password,
      BuildContext context) async {
    toggleRegisterLoading();
    try {
      final credentials = await authInstanceFirebase
          .createUserWithEmailAndPassword(email: email, password: password);
      userData = UserModel(
        uid: credentials.user!.uid.toString(),
        username: username,
        email: email,
        bio: "",
        courses: [],
        like_courses: [],
      );
      await userStoreCollection!
          .doc(credentials.user!.uid.toString())
          .set(userData!.toJson());
      credentials.user!.updateDisplayName(username);
      _user = credentials.user!;
      update();
      Utils.showSnackBar(
          context, 'Account created successfully', primary_color);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.showSnackBar(context, 'Weak password', primary_color);
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar(context, 'Email already in use', primary_color);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleRegisterLoading();
    }
  }

  loginAccount(String email, String password, BuildContext context) async {
    toggleLoginLoading();
    try {
      final credentials = await authInstanceFirebase.signInWithEmailAndPassword(
          email: email, password: password);
      userData = await getUserCollectionData(credentials.user!.uid.toString());
      _user = credentials.user!;
      update();
      Utils.showSnackBar(context, 'Loggedin successfully', primary_color);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, 'Invalid credential', primary_color);
    } catch (e) {
      print(e);
      Utils.showSnackBar(context, 'No internet', primary_color);
    } finally {
      toggleLoginLoading();
    }
  }

  Future<UserModel> getUserCollectionData(String uid) async {
    DocumentSnapshot snapshot = await userStoreCollection!.doc(uid).get();
    log(snapshot.data().toString());
    UserModel data =
        UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return data;
  }

  final _editProfileLoading = false.obs;
  bool get editProfileLoading => (_editProfileLoading.value);
  toggleEditProfileLoading() {
    _editProfileLoading(!_editProfileLoading.value);
    update();
  }

  uploadProfile() async {
    final path = 'profilePhotos/$profileName';
    final file = File(pickedProfile!.path.toString());
    final ref = storageInstanceFirebase.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }

  updateUserProfile(String username, String bio, BuildContext context) async {
    toggleEditProfileLoading();
    var updateProfileMap = {"username": username, "bio": bio};
    if (pickedProfile != null) {
      String? url = await uploadProfile();
      updateProfileMap['photo'] = url!;
      userData.photo = url;
    }
    print(updateProfileMap);
    await userStoreCollection!.doc(userData.uid).update(updateProfileMap).then(
        (value) {
      userData.username = username;
      userData.bio = bio;
      clearPicture();
      Navigator.pop(context);
      Utils.showSnackBar(
          context, 'Profile updated successfully', primary_color);
    }, onError: (e) {
      Utils.showSnackBar(context, 'Error edititng profile', Colors.red);
    });
    update();
    toggleEditProfileLoading();
  }

  FilePickerResult? result;
  PlatformFile? pickedProfile;
  String? profileName;
  UploadTask? uploadTask;
  clearPicture() {
    result = null;
    pickedProfile = null;
    profileName = null;
    update();
  }

  profilePicker() async {
    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null) {
        pickedProfile = result!.files.first;
        profileName = pickedProfile!.name;
        update();
        // print(pickedProfile!.path);
        // print(profileName);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
