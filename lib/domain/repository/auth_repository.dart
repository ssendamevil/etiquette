import 'package:etiquette/data/db/entity/token_entity.dart';

abstract class AuthRepository{
  Future<TokenEntity> register(String phone, int code);
  Future<void> verifyPhone(String phone);
  Future<int> getCode(String phone);
}