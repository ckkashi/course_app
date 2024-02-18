import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/controllers/home_screen_controller.dart';
import 'package:course_app/screens/navigations_views/account_nav_view.dart';
import 'package:course_app/screens/navigations_views/explore_nav_view.dart';
import 'package:course_app/screens/navigations_views/learn_nav_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final firebaseController =
        Provider.of<FirebaseController>(context, listen: false);
    firebaseController.loggedinUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Course App'),
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
          currentIndex: value.selectedIndex,
          onTap: (val) => value.chngSelectedIndex(val),
        ),
        body: SafeArea(
            child: IndexedStack(
          index: value.selectedIndex,
          children: const [
            ExploreNavView(),
            LearnNavView(),
            AccountNavView(),
          ],
        )),
      );
    });
  }
}
