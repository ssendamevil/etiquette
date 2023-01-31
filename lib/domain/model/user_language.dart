import 'package:equatable/equatable.dart';

class UserLanguage extends Equatable{
  final String language;
  final String level;

  const UserLanguage({required this.language, required this.level});

  @override
  List<Object?> get props => [ language, level ];
}