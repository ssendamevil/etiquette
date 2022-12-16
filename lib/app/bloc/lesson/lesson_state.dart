part of 'lesson_bloc.dart';

enum LessonStateType { initial, inProgress, failure, success }

class LessonState extends Equatable {
  final LessonStateType state;
  final Lesson? lesson;
  final String? failureMessage;

  const LessonState({
    this.state = LessonStateType.initial,
    this.lesson,
    this.failureMessage,
  });

  LessonState copyOf({
    LessonStateType? state,
    Lesson? lesson,
    String? failureMessage,
  }) {
    return LessonState(
      state: state ?? this.state,
      lesson: lesson ?? this.lesson,
      failureMessage: failureMessage
    );
  }

  @override
  List<Object?> get props => [ state, lesson, failureMessage, ];
}
