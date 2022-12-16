import 'package:dio/dio.dart';
import 'package:etiquette/data/db/entity/token_entity.dart';
import 'package:etiquette/data/db/hive_token_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:etiquette/data/db/hives.dart';

class AppInitializer{
  static const String _host = 'http://209.97.130.32/';
  static Future<Dio> initialize() async{
    await Hive.initFlutter();
    Hive.registerAdapter(TokenEntityAdapter());
    await Hive.openBox(Hives.boxSettings);
    await Hive.openBox<TokenEntity>(Hives.boxToken);
    await Hive.openBox(Hives.boxUsers);
    await Hive.openBox(Hives.boxLearning);

    Fresh fresh = Fresh.oAuth2(
      tokenStorage: HiveTokenStorage(),
      refreshToken: refreshToken,
      shouldRefresh: (response) => response?.statusCode == 401,
      tokenHeader: (token) => {
        'Authorization': 'Token ${token.accessToken}',
      },
    );

    BaseOptions options = BaseOptions(
      baseUrl: _host,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );

    final dio = Dio(options);
    dio.interceptors.add(fresh);

    return dio;
  }

  static Future<OAuth2Token> refreshToken(
      OAuth2Token? token,
      Dio httpClient,
      ) async {
    final response = await httpClient.post(
      '$_host/users/refresh_token/',
      data: {
        'refresh': token?.refreshToken,
      },
    );
    return OAuth2Token(
      accessToken: response.data['access'],
      refreshToken: response.data['refresh'],
    );
  }
}