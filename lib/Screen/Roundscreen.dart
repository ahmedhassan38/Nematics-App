import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nematicsapp/controller/gameController.dart';

import 'levelscreen.dart';

class RoundPage extends StatefulWidget {
  RoundPage({Key? key, this.type}) : super(key: key);
  var type;
  @override
  State<RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> with TickerProviderStateMixin {
  gameController controller = Get.put(gameController());
  List selected = [];
  Widget Roundbutton({
    required String buttonName,
    required Color color,
    required textColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Container(
        height: 42.h,
        width: 150.w,
        child: ElevatedButton(
          /// my changes
          // color: color,
          onPressed: () {
            if (controller.CurrentRound.value != 10000000) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => levelPage()));
            } else {
              toastMessage("Select Round, Please tap round number to selecct");
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
                fontSize: 20.sp,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Animation? animation;
  static AnimationController? animationController;
  static Animation? animation1;
  @override
  void initState() {
    selected = List.generate(
        controller.roundModel.value.data!.length, (index) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: AnimatedBuilder(
          animation: animationController!,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(
                          animation!.value * MediaQuery.of(context).size.width,
                          0,
                          0),
                      child: Container(
                        height: 100.h,
                        child: Image(
                          image: AssetImage('assets/images/Group.png'),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      height: 150.h,
                      width: 200.w,
                      child: Image(
                        image: AssetImage('assets/images/child.png'),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Select Round',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 27.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.37,
                          child: Obx(() => GridView.count(
                                childAspectRatio: 0.8,
                                crossAxisCount: 3,
                                crossAxisSpacing: 20.0.w,
                                mainAxisSpacing: 20.0.h,
                                padding: EdgeInsets.all(20),
                                children: List.generate(
                                    controller.roundModel.value.data!.length,
                                    (index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selected = List.generate(
                                            controller
                                                .roundModel.value.data!.length,
                                            (index) => false);
                                        selected[index] = true;
                                        controller.CurrentRound.value =
                                            int.parse(controller
                                                .roundModel.value.data!
                                                .elementAt(index)
                                                .title!
                                                .replaceAll('Round #', '')
                                                .toString());
                                      });
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        color: selected.elementAt(index) == true
                                            ? Colors.green
                                            : Color(0xffD9D9D9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${controller.roundModel.value.data!.elementAt(index).title?.replaceAll('Round #', '')}',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 26.sp,
                                            color: selected.elementAt(index) ==
                                                    true
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )),
                        )
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '1',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15.w),
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '2',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15.w),
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '3',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '4',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15.w),
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '5',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15.w),
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '6',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '7',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15.w),
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '8',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15.w),
                    //     Container(
                    //       height: 60.h,
                    //       width: 60.w,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xffD9D9D9),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '9',
                    //           style: GoogleFonts.montserrat(
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 26.sp,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Roundbutton(
                      buttonName: 'Select',
                      color: Colors.black,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(
                          animation1!.value * MediaQuery.of(context).size.width,
                          0,
                          0),
                      child: Container(
                        height: 70.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage('assets/images/Ellipse.png'))),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    ));
  }

  void toastMessage(String Message) {
    Fluttertoast.showToast(
        msg: Message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
