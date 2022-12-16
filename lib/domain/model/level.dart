import 'package:equatable/equatable.dart';
import 'package:etiquette/domain/model/section.dart';

class Level extends Equatable{

  final int id;
  final List<Section> sections;
  final bool isUnlocked;

  const Level({
    required this.id,
    required this.sections,
    required this.isUnlocked,
  });

  @override
  List<Object?> get props => [ id, sections, isUnlocked ];

}