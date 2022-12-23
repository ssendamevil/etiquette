import 'package:dio/dio.dart';
import 'package:etiquette/data/provider/quiz_network_provider.dart';
import 'package:etiquette/domain/model/quiz.dart';
import 'package:etiquette/domain/repository/quiz_repository.dart';

class DataQuizRepository extends QuizRepository{

  final QuizNetworkProvider _quizNetworkProvider;

  DataQuizRepository(Dio dio) : _quizNetworkProvider = QuizNetworkProvider(dio);

  @override
  Future<int> checkResult(int quizId, List<int>? completedQuiz) {
    return _quizNetworkProvider.checkResult(quizId, completedQuiz);
  }

  @override
  Future<Quiz> getQuiz(int quizId) {
    return _quizNetworkProvider.getQuiz(quizId);
  }

}