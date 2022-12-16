import 'dart:collection';

import 'package:etiquette/domain/model/question.dart';
import 'package:etiquette/domain/model/question_option.dart';
import 'package:etiquette/domain/model/quiz.dart';
import 'package:etiquette/domain/repository/quiz_repository.dart';

class MockQuizRepository extends QuizRepository {
  bool isFailed = true;

  @override
  Future<int> checkResult(int quizId, HashMap<int, int> completedQuiz) {
    isFailed = !isFailed;
    return Future.delayed(
      const Duration(seconds: 2),
      () => (isFailed) ? 70 : 90,
    );
  }

  @override
  Future<Quiz> getQuiz(int quizId) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => Quiz(
        id: 1,
        questions: List.of([
          Question(
            id: 1,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 1,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 2,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 3,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 4,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 2,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 5,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 6,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 7,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 8,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 3,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 9,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 10,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 11,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 12,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 4,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 13,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 14,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 15,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 16,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 5,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 17,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 18,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 19,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 20,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 6,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 21,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 22,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 23,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 24,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 7,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 25,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 26,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 27,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 28,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 8,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 29,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 30,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 31,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 32,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 9,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 33,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 34,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 35,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 36,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
          Question(
            id: 10,
            text: 'Название самого сложного вопроса в мире',
            options: List.of([
              const QuestionOption(
                id: 37,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 38,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 39,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
              const QuestionOption(
                id: 40,
                text: 'Это чекбокс с длинным текстом в несколько строк',
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
