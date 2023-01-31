import 'package:equatable/equatable.dart';
import 'package:etiquette/domain/model/user_language.dart';

class User extends Equatable {
  final String fullName;
  final int level;
  final int age;
  final String? birthdayDate;
  final String email;
  final String phone;
  final String description;
  final String avatar;
  final List<UserLanguage>? languages;

  const User({
    required this.fullName,
    required this.level,
    required this.age,
    this.birthdayDate,
    required this.email,
    required this.phone,
    required this.description,
    required this.avatar,
    this.languages,
  });

  @override
  List<Object?> get props => [
        fullName,
        level,
        age,
        birthdayDate,
        email,
        phone,
        avatar,
        languages,
      ];
}
