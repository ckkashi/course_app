import 'package:course_app/controllers/firebase_controller.dart';
import 'package:course_app/controllers/home_screen_controller.dart';
import 'package:course_app/firebase_options.dart';
import 'package:course_app/screens/home_screen.dart';
import 'package:course_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenController()),
        ChangeNotifierProvider(create: (_) => FirebaseController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Course App',
        theme: ThemeData(
            primarySwatch: primary_color,
            appBarTheme: AppBarTheme(
              elevation: 0,
              centerTitle: true,
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500, color: bg_color),
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
        routes: {
          HomeScreen.page_id: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
