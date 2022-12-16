import 'package:equatable/equatable.dart';

class Module extends Equatable {
  final int id;
  final String shortDescription;
  final int lessonsNumber;
  final int lessonsPassed;
  final bool isTestPassed;
  final bool isUnlocked;
  final int quizId;

  const Module({
    required this.id,
    required this.shortDescription,
    required this.lessonsNumber,
    required this.lessonsPassed,
    required this.isTestPassed,
    required this.isUnlocked,
    required this.quizId,
  });

  @override
  List<Object?> get props => [
        id,
        shortDescription,
        lessonsNumber,
        lessonsPassed,
        isTestPassed,
        isUnlocked,
        quizId,
      ];
}
