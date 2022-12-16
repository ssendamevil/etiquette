import 'package:equatable/equatable.dart';

import 'module.dart';

class Section extends Equatable {
  final int id;
  final String title;
  final List<Module> modules;

  const Section({
    required this.id,
    required this.title,
    required this.modules,
  });

  @override
  List<Object?> get props => [ id, title, modules, ];
}
