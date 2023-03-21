import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Screen/GameEnd.dart';
import 'Screen/Leaderboard.dart';
import 'Screen/Login.dart';
import 'Screen/Questionsample1.dart';
import 'Screen/Questionsample2.dart';
import 'Screen/Roundscreen.dart';
import 'Screen/Signup.dart';
import 'Screen/Splashscreen.dart';
import 'Screen/levelscreen.dart';
import 'api_tester.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 752),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
            // home: SplashPage(),
            //GameScreenPage(),
            //LeaderboardPage(),
            //GameEndPage(),
            //Questionsample2Page(),
            //Questionsample1Page(),
            //levelPage(),
            //RoundPage(),
            //LoginPage(),
            //SignupPage(),
          );
        });
  }
}
