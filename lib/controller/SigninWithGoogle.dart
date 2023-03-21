import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nematicsapp/controller/authController.dart';
class firebaseAuthController {
  fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;
  Future GoogleSignOpt(bool signup) async {
    print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
    GoogleSignInAccount _user;
    var googlesignIn = GoogleSignIn();
    var googleUsers = await googlesignIn.signIn();
    print(googleUsers?.email);
    if (googleUsers == null) return;
    _user = googleUsers;
    final googleAuth = await googleUsers.authentication;
    print(googleAuth.idToken);
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //1
    var data = await signInWithGoogle(credential);
    if(data==true && signup==true){
     var value= await AuthController().register('${googleUsers.displayName}', ' ',googleUsers.email, googleUsers.id , 'Student');
     data=value;
    }else if(data==true && signup==false){
     var value=await AuthController().login(googleUsers.email, googleUsers.id);
     if(value!=null){
     data=true;
     }else{
       data=false;
     }
    }
    print("hello" + data.toString());
    return data;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      fba.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  Future<bool> signInWithGoogle(var credentials) async {
    try {
      fba.UserCredential result = await _auth.signInWithCredential(credentials);
      if (result.user != null) {
        // controller.addUser(name:result.user!.displayName ,email:result.user!.email ,password: result.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    fba.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user != null) {
      // controller.addUser(name:result.user!.displayName ,email:result.user!.email ,password: result.user!.uid);
      return true;
    } else {
      return false;
    }
  }
  Future signOut() async {

    var googlesignIn = GoogleSignIn();
    googlesignIn.signOut();

    if(googlesignIn.currentUser != null)
      return await googlesignIn.signOut();
    else
      return await _auth.signOut();
    return await _auth.signOut();
  }
}