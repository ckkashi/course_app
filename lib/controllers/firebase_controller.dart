// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseController extends ChangeNotifier {
  FirebaseAuth instanceFriebase = FirebaseAuth.instance;

  var _user;
  User get getUser => _user;
  loggedinUser() {
    if (_user == null) {
      instanceFriebase.idTokenChanges().listen((User? us) {
        if (us != null) {
          _user = us;
          notifyListeners();
        }
      });
    }
    return _user;
  }

  signout() async {
    await instanceFriebase.signOut();
    _user = instanceFriebase.currentUser;
    notifyListeners();
  }

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;
  toggleLoginLoading() {
    _loginLoading = !_loginLoading;
    notifyListeners();
  }

  bool _registerLoading = false;
  bool get registerLoading => _registerLoading;
  toggleRegisterLoading() {
    _registerLoading = !_registerLoading;
    notifyListeners();
  }

  createAccount(String username, String email, String password,
      BuildContext context) async {
    toggleRegisterLoading();
    try {
      final credentials = await instanceFriebase.createUserWithEmailAndPassword(
          email: email, password: password);
      credentials.user!.updateDisplayName(username);
      _user = credentials.user!;
      notifyListeners();
      Utils.showSnackBar(
          context, 'Account created successfully', success_color);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.showSnackBar(context, 'Weak password', primary_color);
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar(context, 'Email already in use', primary_color);
      }
    } catch (e) {
      print(e);
    } finally {
      toggleRegisterLoading();
    }
  }

  loginAccount(String email, String password, BuildContext context) async {
    toggleLoginLoading();
    try {
      final credentials = await instanceFriebase.signInWithEmailAndPassword(
          email: email, password: password);
      _user = credentials.user!;
      notifyListeners();
      Utils.showSnackBar(context, 'Loggedin successfully', success_color);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context, 'Invalid credential', primary_color);
    } catch (e) {
      print(e);
    } finally {
      toggleLoginLoading();
    }
  }
}
