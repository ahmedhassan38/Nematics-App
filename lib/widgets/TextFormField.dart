import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextformField extends StatelessWidget {
  final String hinttext;
  final bool obscureText;
  TextformField({required this.hinttext, required this.obscureText});


  static TextEditingController email_ = TextEditingController();
  static TextEditingController password_ = TextEditingController();
  static TextEditingController confirm_password_ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: Container(
        height: 50.h,
        child: TextFormField(
          controller: hinttext=='Email'?email_:hinttext=='Password'?password_:confirm_password_,
          // maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
              color: Colors.black,
            ),
            hintText: hinttext,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// class FieldChanger{
//   static String email_ = '';
//   static String password_ = '';
//   static String confirmm_password_ = '';
// }