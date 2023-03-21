import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:nematicsapp/Model/LevelsModel.dart';
import 'package:nematicsapp/Model/RoundsModel.dart';
import 'package:nematicsapp/controller/gameController.dart';
class levelController extends GetxController{

  Future<LevelModel> GetLevels()async{
    LevelModel model=new LevelModel();
    var value=await http.get(Uri.parse('$BaseUrl/api/level/get'));
    if(value.statusCode==200){
      model=LevelModel.fromJson(jsonDecode(value.body));
    }else{

    }
    return model;
  }

}