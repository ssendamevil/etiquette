import 'package:equatable/equatable.dart';

import 'module.dart';

class Section extends Equatable {
  final int id;
  final String title;
  final List<Module> modules;
  final bool isUnlocked;

  const Section({
    required this.id,
    required this.title,
    required this.modules,
    required this.isUnlocked,
  });

  @override
  List<Object?> get props => [ id, title, modules, isUnlocked ];
}
