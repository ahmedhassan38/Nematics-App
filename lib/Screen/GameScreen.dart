import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/TextFormField.dart';
import 'Roundscreen.dart';

class GameScreenPage extends StatefulWidget {
  const GameScreenPage({Key? key}) : super(key: key);

  @override
  State<GameScreenPage> createState() => _GameScreenPageState();
}

class _GameScreenPageState extends State<GameScreenPage> with TickerProviderStateMixin{
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
      body: AnimatedBuilder(
          animation: animationController!,
          builder: (context,child) {
            return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Container(
                      padding: EdgeInsets.only(right: 20.w),
                      height: 150.h,
                      width: 200.w,
                      child: Image(
                        image: AssetImage('assets/images/child.png'),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.w, bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'All Games',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 30.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.w, right: 40.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RoundPage(type: 0,)));
                        },
                        child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Math',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RoundPage(type:1,)));
                        },
                        child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'English',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RoundPage(type: 2,)));
                        },
                        child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Geometric',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RoundPage(type: 3,)));
                        },child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Puzzle',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RoundPage(type: 4,)));
                        },
                        child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'IQ Games',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RoundPage(type: 5,)));
                        },
                        child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Drawing',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
            ),
          );
        }
      ),
    );
  }
}
