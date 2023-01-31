import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String fullName;
  final int level;
  //final String residence;
  final int age;
  final String? birthdayDate;
  final String email;
  final String phone;
  final String description;

  const User({
    required this.fullName,
    required this.level,
    //required this.residence,
    required this.age,
    this.birthdayDate,
    required this.email,
    required this.phone,
    required this.description,
  });

  @override
  List<Object?> get props => [
        fullName,
        level,
        age,
        birthdayDate,
        email,
        phone,
      ];
}
