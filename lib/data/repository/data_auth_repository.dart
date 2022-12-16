import 'package:dio/dio.dart';
import 'package:etiquette/data/db/entity/token_entity.dart';
import 'package:etiquette/data/provider/auth_network_provider.dart';
import 'package:etiquette/domain/repository/auth_repository.dart';

class DataAuthRepository extends AuthRepository{

  final AuthNetworkProvider _authNetworkProvider;

  DataAuthRepository(Dio dio) : _authNetworkProvider = AuthNetworkProvider(dio);

  @override
  Future<int> getCode(String phone) {
    return _authNetworkProvider.getCode(phone);
  }

  @override
  Future<TokenEntity> register(String phone, int code) {
    return _authNetworkProvider.register(phone, code);
  }

  @override
  Future<void> verifyPhone(String phone) {
    return _authNetworkProvider.verifyPhone(phone);
  }

}