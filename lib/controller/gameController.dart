import 'package:get/get.dart';
import 'package:nematicsapp/Model/LevelsModel.dart';
import 'package:nematicsapp/Model/RoundsModel.dart';
var BaseUrl='https://stackbuffers.com/Nematics';
class gameController extends GetxController{
var totalScores=0.obs;
var round=0.obs;
var level=0.obs;
var CurrentRound=10000000.obs;
var CurrentLevel=10000000.obs;
Rx<RoundModel> roundModel=new RoundModel().obs;
Rx<LevelModel> levelModel=new LevelModel().obs;

}