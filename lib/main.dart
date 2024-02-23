import 'package:course_app/firebase_options.dart';
import 'package:course_app/screens/auth_views/edit_profile_view.dart';
import 'package:course_app/screens/home_screen.dart';
import 'package:course_app/screens/my_courses_views/add_course_view.dart';
import 'package:course_app/screens/my_courses_views/my_course_view.dart';
import 'package:course_app/utils/colors.dart';
import 'package:course_app/utils/routes.dart';
import 'package:course_app/utils/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: bg_color,
      systemNavigationBarIconBrightness: Brightness.dark));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_name_string,
      theme: ThemeData(
          primarySwatch: primary_color,
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: bg_color,
            iconTheme: IconThemeData(color: primary_color),
            actionsIconTheme: IconThemeData(color: primary_color),
            titleTextStyle: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w500, color: primary_color),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: bg_color,
            selectedItemColor: primary_color,
            unselectedItemColor: text_secondary_color,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: bg_color),
      initialRoute: HomeScreen.page_id,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
