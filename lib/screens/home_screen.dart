// ignore_for_file: non_constant_identifier_names

import 'package:course_app/controllers/course_controller.dart';
import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/controllers/home_screen_controller.dart';
import 'package:course_app/screens/navigations_views/account_nav_view.dart';
import 'package:course_app/screens/navigations_views/explore_nav_view.dart';
import 'package:course_app/screens/navigations_views/learn_nav_view.dart';
import 'package:course_app/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static const page_id = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final firebaseController =
    //     Provider.of<FirebaseController>(context, listen: false);
    // firebaseController.loggedinUser();
  }

  final home_controller = Get.put(HomeScreenController());
  final firebase_controller = Get.put(FirebaseController());
  final course_controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              app_name_string,
            ),
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined), label: 'Explore'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book), label: 'Learn'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: 'Account'),
            ],
            currentIndex: home_controller.selectedIndex,
            onTap: (val) => home_controller.chngSelectedIndex(val),
          ),
          body: SafeArea(
              child: IndexedStack(
            index: home_controller.selectedIndex,
            children: [
              ExploreNavView(),
              const LearnNavView(),
              AccountNavView(),
            ],
          )),
        );
      }),
    );
  }
}
