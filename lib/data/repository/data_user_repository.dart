import 'package:dio/dio.dart';
import 'package:etiquette/data/provider/user_network_provider.dart';
import 'package:etiquette/domain/model/user.dart';
import 'package:etiquette/domain/repository/user_repository.dart';

class DataUserRepository extends UserRepository{

  UserNetworkProvider _userNetworkProvider;

  DataUserRepository(Dio dio) : _userNetworkProvider = UserNetworkProvider(dio);

  @override
  Future<void> editUser(User user) {
    return _userNetworkProvider.editUser(user);
  }

  @override
  Future<User> getUserProfile() {
    return _userNetworkProvider.getUserProfile();
  }

}