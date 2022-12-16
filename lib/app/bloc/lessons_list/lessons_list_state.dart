part of 'lessons_list_bloc.dart';

enum LessonsListStateType { initial, inProgress, failure, success }

class LessonsListState extends Equatable {
  final LessonsListStateType state;
  final List<Lesson>? lessons;
  final int? quizId;
  final String? failureMessage;

  const LessonsListState({
    this.state = LessonsListStateType.initial,
    this.lessons,
    this.quizId,
    this.failureMessage,
  });

  LessonsListState copyOf({
    LessonsListStateType? state,
    List<Lesson>? lessons,
    int? quizId,
    String? failureMessage,
  }){
    return LessonsListState(
      state: state ?? this.state,
      lessons: lessons ?? this.lessons,
      quizId: quizId ?? this.quizId,
      failureMessage: failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    state,
    lessons,
    quizId,
    failureMessage,
  ];
}