import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/gameController.dart';
import 'Questionsample1.dart';

class levelPage extends StatefulWidget {
  const levelPage({Key? key}) : super(key: key);

  @override
  State<levelPage> createState() => _levelPageState();
}

class _levelPageState extends State<levelPage> with TickerProviderStateMixin {
  gameController controller = Get.put(gameController());
  List selected = [];

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

  Widget Levelbutton({
    required String buttonName,
    required Color color,
    required textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Container(
        height: 42.h,
        width: 150.w,
        child: ElevatedButton(
          /// my changes
          // color: color,
          onPressed: () {
            if (controller.CurrentLevel.value != 10000000) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Questionsample1Page()),
                  (route) => false);
            } else {
              toastMessage("Select Level, Please tap Level number to selecct");
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
                            animation!.value *
                                MediaQuery.of(context).size.width,
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
                        'Select Level',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 27.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 40.h),
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
                                  controller.levelModel.value.data!.length,
                                  (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      controller.CurrentLevel.value = int.parse(
                                          controller.levelModel.value.data!
                                              .elementAt(index)
                                              .title!
                                              .replaceAll('Level #', '')
                                              .toString());
                                      selected = List.generate(
                                          controller
                                              .levelModel.value.data!.length,
                                          (index) => false);
                                      selected[index] = true;
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
                                        '${controller.levelModel.value.data!.elementAt(index).title?.replaceAll('Level #', '')}',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 26.sp,
                                          color:
                                              selected.elementAt(index) == true
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )),
                      ),
                      Levelbutton(
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
                            animation1!.value *
                                MediaQuery.of(context).size.width,
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
      ),
    );
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
