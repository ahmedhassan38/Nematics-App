import 'dart:convert';

import 'package:nematicsapp/Model/UserModel.dart';
import 'package:http/http.dart' as http;

import '../urls.dart';
class AuthController{

  Future <bool> register(String fname,String lname,String email,String password,String type)async{
    var response =await http.get(
        Uri.parse(registerUrl).replace(
            queryParameters:{
            'first_name': fname,
            'last_name': lname,
            'email':email,
            'password':password,
            'type' : type
            })
    );
    if(response.statusCode==200){
      print('Register Successfully');
      return true;
    }else{
      return false;
    }
  }

  Future<UserModel> login(String email, String password)async{
      var response = await http.get(
          Uri.parse(loginUrl).replace(
              queryParameters:{
              'email': email,
              'password':password
          })
      );
      if(response.statusCode ==200){
        var userModel = jsonDecode(response.body.toString());
        print('Success');
        print(userModel.toString());
        // return true;
        return UserModel.fromJson(userModel);
      }
      else{
        // return null;
        var userModel = jsonDecode(response.body.toString());
        // return false;
        return UserModel.fromJson(userModel);
      }
    // return UserModel();
  }



  Future <bool> update(String fname,String lname,String email,String password,String type)async{
    UserModel userModel ;
    var response=await http.get(Uri.parse(updateUrl).replace(
        queryParameters:{
          'first_name': fname,
          'last_name': lname,
          'email':email,
          'password':password,
          'type' : type
        })
    );
    if(response.statusCode==200){
      userModel = UserModel.fromJson(jsonDecode(response.body));
      return true;
      // return userModel;
    }else{
      return  false;
      // return  UserModel();
    }
  }




  Future <bool> preview(int user_id)async{
    UserModel userModel ;
    var response=await http.get(Uri.parse(previewUrl));
    if(response.statusCode==200){
      userModel = UserModel.fromJson(jsonDecode(response.body));
      return true;
      // return userModel;
    }else{
      return  false;
      // return  UserModel();
    }
  }

}