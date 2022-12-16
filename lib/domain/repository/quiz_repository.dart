import 'dart:collection';

import 'package:etiquette/domain/model/question.dart';
import 'package:etiquette/domain/model/quiz.dart';

abstract class QuizRepository{

  Future<Quiz> getQuiz(int quizId);
  Future<int> checkResult(int quizId, HashMap<int, int> completedQuiz);

}