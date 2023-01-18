import 'package:etiquette/data/db/entity/token_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hives.dart';

class BoxHelper{

  static bool isLoggedIn(){
    return Hive.box(Hives.boxSettings).get(Hives.keyIsLoggedIn);
  }

  static bool hasToken(){
    return Hive.box<TokenEntity>(Hives.boxToken).get(Hives.keyToken) != null;
  }

  static void saveUserId(int userId){
    Hive.box(Hives.boxUsers).put(Hives.keyUserId, userId);
  }

  static void saveToken(TokenEntity token){
    Hive.box<TokenEntity>(Hives.boxToken).put(Hives.keyToken, token);
  }

  static int? getPositionType(){
    return Hive.box(Hives.boxLearning).get(Hives.keyPositionType);
  }

  static int? getPositionId(){
    return Hive.box(Hives.boxLearning).get(Hives.keyPositionId);
  }

  static bool? getCharityShow(){
    return Hive.box(Hives.boxSettings).get(Hives.keyCharityShow);
  }

  static void savePositionType(int typeId){
    Hive.box(Hives.boxLearning).put(Hives.keyPositionType, typeId);
  }

  static void savePositionId(int positionId){
    Hive.box(Hives.boxLearning).put(Hives.keyPositionId, positionId);
  }

  static void saveCharityShow(bool charityShow){
    Hive.box(Hives.boxSettings).put(Hives.keyCharityShow, charityShow);
  }
}