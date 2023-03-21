import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nematicsapp/controller/SigninWithGoogle.dart';
import 'package:nematicsapp/controller/authController.dart';

import '../widgets/TextFormField.dart';
import 'Login.dart';
// import 'globals.dart' as globals;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin{
  firebaseAuthController controller=new firebaseAuthController();


  //State Vars
  var auth = AuthController();
  bool emailFieldEmpty = false;
  bool emailFieldPattern  = false;
  bool passwordFieldEmpty = false;
  bool passwordMatched = true;
  bool isRegistrationFailed = false;
  bool signupLoader = false;
  static String emailMessage ='';

  Animation? animation2;
  AnimationController ?animationController1;
  Animation? animation3;
  @override
  void initState() {
    animationController1=AnimationController(vsync: this,duration: Duration(seconds: 1));
    animation2=Tween(begin: -1,end: 0.0).animate(CurvedAnimation(parent: animationController1!, curve:Curves.bounceIn));
    animationController1!.forward();
    animation3=Tween(begin: 1,end: 0.0).animate(CurvedAnimation(parent: animationController1!, curve:Curves.bounceIn));
    animationController1!.forward();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    animationController1!.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(

      SnackBar(
        content: const Text('Registration Failed'),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


  Widget SignUpbutton({
    required String buttonName,
    required Color color,
    required textColor,
  }) {
    return Container(
      height: 42.h,
      width: 150.w,
      child: RaisedButton(
        color: color,
        onPressed: () async {

          this.emailFieldEmpty = TextformField.email_.text.isEmpty;
          this.passwordFieldEmpty = TextformField.email_.text.isEmpty;
          this.passwordMatched = TextformField.password_.text==TextformField.confirm_password_.text && !TextformField.password_.text.isEmpty;
          print(passwordMatched.toString()+'marh');
          this.emailFieldPattern = TextformField.email_.text.contains('@');

          if (!emailFieldEmpty && (passwordMatched) && !passwordFieldEmpty){
            // if(!TextformField.email_.text.contains("@")){
            //   return;
            // }
            this.setState(() {
              signupLoader = true;
            });
            bool isRegistered = await  auth.register('saad', 'akhtar',TextformField.email_.text, TextformField.password_.text , 'Student');
            // bool isRegistered = await  auth.register('saad', '-', TextformField.email_.text, TextformField.password_.text , 'type');
            if(isRegistered){
              TextformField.email_.text = '';
              TextformField.password_.text = '';
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()));
            }
            else{

              this.setState(() {
                isRegistrationFailed = true;
              });
              print('Not Regsiterd');
            }
          }
          else if(emailFieldEmpty){
            setState(() {
              emailMessage ='email required';
            });
          }
          else if (passwordFieldEmpty) {
          }
          else{
            _showToast(context);
            setState(() {
              emailFieldEmpty = TextformField.email_.text.trim().isEmpty;
              passwordFieldEmpty = TextformField.email_.text.trim().isEmpty;
              passwordMatched = TextformField.password_.text==TextformField.confirm_password_.text;

            });
          }

        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
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
      inAsyncCall: signupLoader,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedBuilder(
            animation: animationController1!,
            builder: (context,child) {
              return  SafeArea(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(animation2!.value*MediaQuery.of(context).size.width,0, 0),
                                child: Container(
                                  height: 100.h,
                                  child: Image(
                                    image: AssetImage('assets/images/Group.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 210.h,
                                child: Image(
                                  image: AssetImage('assets/images/Ellipse2.png'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(animation3!.value*MediaQuery.of(context).size.width,0, 0),
                                child: Image(
                                  height: 150.h,
                                  width: 120.w,
                                  image: AssetImage('assets/images/Ellipse.png'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned.fill(
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(60),
                              child: Container(
                                height: 130.h,
                                width: 120.w,
                                child: Image(
                                  image: AssetImage('assets/images/logo.png'),
                                ),
                              ),
                            ),
                            TextformField(
                                hinttext: 'Email', obscureText: false
                            ),
                            emailFieldEmpty && !TextformField.email_.text.contains('@')?Text('email required (abc@gmail.com)',style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontSize: 11),):Container(),
                            // if (!TextformField.email_.text.contains('@')) Container(alignment:Alignment.topLeft,padding: EdgeInsets.only(left: 26,bottom: 5),child: Text('email must contain @',style: TextStyle(color: emailFieldPattern?Colors.grey:Colors.red,fontWeight: FontWeight.normal,fontSize: 11),),),
                            TextformField(hinttext: 'Password', obscureText: true),
                            passwordFieldEmpty?Text('password required',style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontSize: 11),):Container(),
                            TextformField(
                                hinttext: 'Confirm Password', obscureText: true),
                            passwordMatched?Container():Text('password doesn\'t matches',style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontSize: 11),),
                            SizedBox(height: 20.h),
                            SignUpbutton(
                              buttonName: 'Sign Up',
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
                              'Sign Up with social account',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.04.h,
                                  child: Image(
                                    image: AssetImage('assets/images/facebook.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                InkWell(
                                  onTap: ()async{
                                   var cond=await firebaseAuthController().GoogleSignOpt(true);
              if(cond){
              Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
              }
              else{
              this.setState(() {
              isRegistrationFailed = true;
              });
              print('Not Regsiterd');
              }

                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.04.h,
                                    child: Image(
                                      image: AssetImage('assets/images/google.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            TextButton(
                              onPressed: () {
                                TextformField.password_.text = '';
                                TextformField.email_.text = '';
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                'Sign in',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            ),
                            isRegistrationFailed?SnackBar(
                              content: Text('Registration Failed'),
                            ):Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

/*


 */
