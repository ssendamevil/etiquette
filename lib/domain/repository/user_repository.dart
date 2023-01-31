import 'package:etiquette/domain/model/user.dart';

abstract class UserRepository{
  Future<User> getUserProfile();
  Future<void> editUser(User user);
}