part of 'quiz_bloc.dart';

enum QuizStateType { initial, inProgress, success, failure }

class QuizState extends Equatable {
  final QuizStateType state;
  final Quiz? quiz;
  final int? result;
  final String? failureMessage;

  const QuizState({
    this.state = QuizStateType.initial,
    this.quiz,
    this.result,
    this.failureMessage,
  });

  QuizState copyOf({
    QuizStateType? state,
    Quiz? quiz,
    int? result,
    String? failureMessage,
  }) {
    return QuizState(
      state: state ?? this.state,
      quiz: quiz ?? this.quiz,
      result: result ?? this.result,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [ state, quiz, result, failureMessage ];


}
