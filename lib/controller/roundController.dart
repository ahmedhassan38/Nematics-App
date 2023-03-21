import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:nematicsapp/Model/RoundsModel.dart';
import 'package:nematicsapp/controller/gameController.dart';
class roundController extends GetxController{

  Future<RoundModel> GetRound()async{
    RoundModel model=new RoundModel();
    var value=await http.get(Uri.parse('$BaseUrl/api/round/get'));
    if(value.statusCode==200){
      model=RoundModel.fromJson(jsonDecode(value.body));
    }else{

    }
    return model;
  }

}