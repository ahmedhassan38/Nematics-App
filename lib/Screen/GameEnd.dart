import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nematicsapp/Screen/Questionsample1.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/TextFormField.dart';
import 'GameScreen.dart';
import 'Leaderboard.dart';
import 'Roundscreen.dart';

class GameEndPage extends StatefulWidget {
  const GameEndPage({Key? key}) : super(key: key);

  @override
  State<GameEndPage> createState() => _GameEndPageState();
}

class _GameEndPageState extends State<GameEndPage> with TickerProviderStateMixin{
  static Animation? animation;
  static AnimationController ?animationController;
  static Animation? animation1;
  @override
  void initState() {
    animationController=AnimationController(vsync: this,duration: Duration(seconds: 1));
    animation=Tween(begin: -1,end: 0.0).animate(CurvedAnimation(parent: animationController!, curve:Curves.bounceIn));
    animationController!.forward();
    animation1=Tween(begin: 1,end: 0.0).animate(CurvedAnimation(parent: animationController!, curve:Curves.bounceIn));
    animationController!.forward();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: animationController!,
            builder: (context,child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(animation!.value*MediaQuery.of(context).size.width,0, 0),
                      child: Container(
                        height: 100.h,
                        child: Image(
                          image: AssetImage('assets/images/Group.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 70.w, top: 20.h),
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.h,
                        child: Image(
                          image: AssetImage('assets/images/Logo1.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Game Over',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'You Scored',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CircularPercentIndicator(
                      radius: 45.r,
                      lineWidth: 5,
                      percent: 0.9,
                      center: Text(
                        "19/20",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                      progressColor: Color(0xff05FF00),
                    ),
                    SizedBox(height: 30.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questionsample1Page()));
                      },
                      child: Container(
                        height: 40.h,
                        width: 170.w,
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Questionsample1Page()));
                      },
                      child: Container(
                        height: 40.h,
                        width: 170.w,
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Play Again',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaderboardPage()));
                      },
                      child: Container(
                        height: 40.h,
                        width: 170.w,
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Exit',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   Transform(
                     transform: Matrix4.translationValues(animation1!.value*MediaQuery.of(context).size.width,0, 0),
                     child: Container(
                        height: 70.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/Ellipse.png')
                        )
                        ),
                      ),
                   ),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
