import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nematicsapp/Model/UserModel.dart';
import 'package:nematicsapp/controller/SigninWithGoogle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../controller/authController.dart';
import '../widgets/TextFormField.dart';
import 'Leaderboard.dart';
import 'Signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  var auth = AuthController();
  bool emailFieldEmpty = false;
  bool passwordFieldEmpty = false;
  static bool isLoginFailed = false;
  bool loginLoader = false;
  static Animation? animation;
  static AnimationController? animationController;
  static Animation? animation1;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: -1, end: 0.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.bounceIn));
    animationController!.forward();
    animation1 = Tween(begin: 1, end: 0.0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.bounceIn));
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

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Invalid Credentials'),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget Loginbutton({
    required String buttonName,
    required Color color,
    required textColor,
  }) {
    return Container(
      height: 40.h,
      width: 150.w,
      child: ElevatedButton(
        /// my changes
        // color: color,
        onPressed: () async {
          // this.setState(() {
          //   loginLoader = true;
          // });
          emailFieldEmpty = TextformField.email_.text.isEmpty;
          passwordFieldEmpty = TextformField.email_.text.isEmpty;

          if (!emailFieldEmpty && !passwordFieldEmpty) {
            this.setState(() {
              loginLoader = true;
            });
            UserModel isRegistered = await auth.login(
                TextformField.email_.text, TextformField.password_.text);
            if (isRegistered.data != null) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('login', true);
              TextformField.email_.text = '';
              TextformField.password_.text = '';
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LeaderboardPage()));
            } else {
              _showToast(context);
              this.setState(() {
                loginLoader = false;
              });
            }
          } else {
            this.setState(() {
              _showToast(context);
              emailFieldEmpty = TextformField.email_.text.isEmpty;
              passwordFieldEmpty = TextformField.email_.text.isEmpty;
            });
          }
        },

        /// my changes
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            buttonName,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(
        color: Colors.black,
      ),
      inAsyncCall: loginLoader,
      child: Scaffold(
        body: AnimatedBuilder(
            animation: animationController!,
            builder: (context, child) {
              return SafeArea(
                child: Shimmer(
                  duration: Duration(seconds: 3), //Default value
                  interval: Duration(
                      seconds: 5), //Default value: Duration(seconds: 0)
                  color: Colors.white, //Default value
                  colorOpacity: 0.2, //Default value
                  enabled: true, //Default value
                  direction: ShimmerDirection.fromLTRB(),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  animation!.value *
                                      MediaQuery.of(context).size.width,
                                  0,
                                  0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: Image(
                                  image: AssetImage('assets/images/Group.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(
                                  0,
                                  0,
                                  animation!.value *
                                      MediaQuery.of(context).size.width),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.14.h,
                                width:
                                    MediaQuery.of(context).size.width * 0.4.w,
                                child: Image(
                                  image: AssetImage('assets/images/logo.png'),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 180.h,
                                    // width: 80.w,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/Ellipse2.png'),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextformField(
                                          hinttext: 'Email',
                                          obscureText: false),
                                      emailFieldEmpty
                                          ? Text(
                                              'email required',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11),
                                            )
                                          : Container(),
                                      TextformField(
                                          hinttext: 'Password',
                                          obscureText: true),
                                      passwordFieldEmpty
                                          ? Text(
                                              'password required',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Loginbutton(
                              buttonName: 'Login',
                              color: Colors.black,
                              textColor: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'Or',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Text(
                              'Login with social account',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.04.h,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/facebook.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                InkWell(
                                  onTap: () async {
                                    var cond = await firebaseAuthController()
                                        .GoogleSignOpt(false);
                                    if (cond) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool('login', true);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LeaderboardPage()));
                                    } else {
                                      _showToast(context);
                                      this.setState(() {
                                        loginLoader = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.04.h,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/google.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Transform(
                                  transform: Matrix4.translationValues(
                                      animation1!.value *
                                          MediaQuery.of(context).size.width,
                                      0,
                                      0),
                                  child: Image(
                                    height: 110.h,
                                    width: 120.w,
                                    image:
                                        AssetImage('assets/images/Ellipse.png'),
                                  ),
                                ),
                              ],
                            ),

                            // isLoginFailed?SnackBar(
                            //   content: Text('Login Failed. Try with other email or password'),
                            // ):Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
