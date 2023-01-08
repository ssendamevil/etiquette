import 'package:dio/dio.dart';
import 'package:etiquette/data/db/entity/token_entity.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:get_it/get_it.dart';

class AuthNetworkProvider {
  final Dio _dio;

  AuthNetworkProvider(this._dio);

  Future<void> verifyPhone(String phone) async {
    var response = await _dio.post(
      'users/verify_phone/',
      data: {'phone': phone},
    );
  }

  Future<TokenEntity> register(String phone, int code) async {
    var response = await _dio.post('users/register/', data: {
      'phone': phone,
      'code': code,
    });
    GetIt.I<Fresh>().setToken(OAuth2Token(
      accessToken: response.data['token']['access'],
      refreshToken: response.data['token']['refresh'],
    ));
    return TokenEntity(
      response.data['token']['access'],
      response.data['token']['refresh'],
    );
  }

  Future<int> getCode(String phone) async {
    var response = await _dio.get(
      'users/get_code/',
      queryParameters: {'phone': phone},
    );

    return response.data['code'];
  }
}
