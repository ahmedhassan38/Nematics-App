import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_animations/im_animations.dart';
import 'package:nematicsapp/Screen/Login.dart';
import 'package:nematicsapp/controller/SigninWithGoogle.dart';
import 'package:nematicsapp/controller/gameController.dart';
import 'package:nematicsapp/controller/levelController.dart';
import 'package:nematicsapp/controller/roundController.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/TextFormField.dart';
import 'GameScreen.dart';
import 'Roundscreen.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> with TickerProviderStateMixin {
  gameController controller=Get.put(gameController());
  levelController LevelController=Get.put(levelController());
  roundController RoundController=Get.put(roundController());
  Animation? animation;
  AnimationController ?animationController;
  Animation? animation1;
  @override
  void initState() {
    animationController=AnimationController(vsync: this,duration: Duration(seconds: 1));
    animation=Tween(begin: -1,end: 0.0).animate(CurvedAnimation(parent: animationController!, curve:Curves.bounceIn));
    animationController!.forward();
    animation1=Tween(begin: 1,end: 0.0).animate(CurvedAnimation(parent: animationController!, curve:Curves.bounceIn));
    animationController!.forward();
    GetData();

    // TODO: implement initState
    super.initState();
  }
  GetData()async{
    controller.roundModel.value=await RoundController.GetRound();
    controller.levelModel.value=await LevelController.GetLevels();
    print(controller.roundModel.value.data!.length);
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 60.h,
                        child: Image(
                          image: AssetImage('assets/images/Logo1.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 10),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.share_up,
                              size: 20.sp, color: Colors.black),
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('login', false);
                              TextformField.password_.text = '';
                              TextformField.email_.text = '';
                              firebaseAuthController().signOut().then((value) =>
                              {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => LoginPage()))
                              });

                            },
                            child: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                'Total Scores:',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 7.w),
                             Obx(()=> Text(
                                '${controller.totalScores}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                ),)
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                'Rounds:',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 7.w),
                              Obx(()=>Text(
                                '${controller.round}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                ),)
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                'Levels:',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 7.w),
                              Obx(()=>Text(
                                '${controller.level}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Image(
                  image: AssetImage('assets/images/child.png'),
                ),
                Column(
                  children: [
                    InkWell(


    onTap:(){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => RoundPage(type: 0,)));
                      },
                      child: ColorSonar(
                        // wavesDisabled: true,
                        // waveMotion: WaveMotion.synced,
                        contentAreaRadius: 30.r,
                        waveFall: 10.r,
                        //waveMotionEffect: Curves.elasticIn,
                        waveMotion: WaveMotion.synced,
                         duration: Duration(milliseconds: 1000),
                        waveMotionEffect: Curves.ease,
                        innerWaveColor: Colors.grey.shade300,
                        outerWaveColor: Colors.grey.shade100,
                        middleWaveColor: Colors.grey.shade200,
                        child: Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffD9D9D9),
                          ),
                          child: Icon(Icons.play_arrow, size: 40),
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
