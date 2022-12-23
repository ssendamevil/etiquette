import 'package:etiquette/domain/model/quiz.dart';

abstract class QuizRepository{

  Future<Quiz> getQuiz(int quizId);
  Future<int> checkResult(int quizId, List<int>? completedQuiz);

}