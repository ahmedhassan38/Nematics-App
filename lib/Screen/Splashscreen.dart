import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Leaderboard.dart';
import 'Login.dart';
import 'Signup.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    _navigatetologinScreen();
  }

  void _navigatetologinScreen() async {
    await getSavedData().then((value){
      Timer(
          Duration(seconds: 3),
          (() => Navigator.of(context).pushReplacement(

              MaterialPageRoute(builder: (context) {

                if(value == true){
                  return LeaderboardPage();
                }
                else{
                  return LoginPage();
                }
              }))));

    }); }
  Future<bool?>getSavedData()async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('login');
    return boolValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage('assets/images/Group.png'),
                      ),
                    ],
                  ),
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                        image: AssetImage('assets/images/Ellipse.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
