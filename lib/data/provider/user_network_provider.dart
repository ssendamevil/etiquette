import 'package:dio/dio.dart';
import 'package:etiquette/domain/model/user.dart';
import 'package:etiquette/domain/model/user_language.dart';

class UserNetworkProvider {
  final Dio _dio;

  const UserNetworkProvider(this._dio);

  Future<User> getUserProfile() async {
    var response = await _dio.get('/users/get_user/');
    return _parseUser(response.data);
  }

  Future<void> editUser(User user) async {
    await _dio.put('/users/edit_user/', data: {
      'full_name': user.fullName,
      'birthday_date': user.birthdayDate,
      'email': user.email,
      'phone': user.phone,
      'description': user.description,
      'avatar': MultipartFile.fromFile(user.avatar),
      'languages': user.languages,
    });
  }

  User _parseUser(dynamic e) {
    return User(
      fullName: e['full_name'],
      level: e['level'],
      age: e['age'],
      email: e['email'],
      phone: e['phone'],
      description: e['description'],
      avatar: e['avatar'],
      languages:
          (e['languages'] as List).map((e) => _parseUserLanguage(e)).toList(),
    );
  }

  UserLanguage _parseUserLanguage(e) {
    return UserLanguage(language: e['language'], level: e['level']);
  }
}
