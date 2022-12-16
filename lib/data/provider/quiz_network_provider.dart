import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:etiquette/domain/model/question.dart';
import 'package:etiquette/domain/model/question_option.dart';
import 'package:etiquette/domain/model/quiz.dart';

class QuizNetworkProvider {
  final Dio _dio;

  const QuizNetworkProvider(this._dio);

  Future<Quiz> getQuiz(int quizId) async {
    var response = await _dio.get(
      'quizzes/get_quiz',
      queryParameters: {
        'id': quizId,
      },
    );
    
    return _parseQuiz(response.data);
  }
  
  Future<int> checkResult(int quizId, HashMap<int, int> completedQuiz) async{
    var response = await _dio.post(
      'quizzes/check_result',
      data: {
        'quiz_id': quizId,
        'answers': completedQuiz,
      },
    );
    
    return int.parse(response.data['result'].toString());
  }

  Quiz _parseQuiz(dynamic e) {
    return Quiz(
      id: e['id'],
      questions: (e['questions'] as List)
          .map((e) => _parseQuestion(e))
          .toList(),
    );
  }

  Question _parseQuestion(dynamic e) {
    return Question(
      id: e['id'],
      text: e['text'],
      options: (e['options'] as List).map((e) => _parseOption(e)).toList(),
    );
  }
  
  QuestionOption _parseOption(dynamic e){
    return QuestionOption(
      id: e['id'],
      text: e['text'],
    );
  }
}
