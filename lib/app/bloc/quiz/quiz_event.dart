part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
}

class QuizStarted extends QuizEvent{

  final int quizId;

  const QuizStarted(this.quizId);

  @override
  List<Object?> get props => [ quizId ];
}

class QuizCompleted extends QuizEvent{

  final int quizId;
  final HashMap<int, int> completedQuiz;

  const QuizCompleted(this.quizId, this.completedQuiz);

  @override
  List<Object?> get props => [ quizId, completedQuiz, ];

}
