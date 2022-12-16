import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/domain/model/quiz.dart';
import 'package:etiquette/domain/repository/quiz_repository.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepository;

  QuizBloc(this._quizRepository) : super(const QuizState()) {
    on<QuizStarted>(_onStarted);
    on<QuizCompleted>(_onCompleted);
  }

  Future<void> _onStarted(QuizStarted event, Emitter emit) async {
    try {
      emit(state.copyOf(state: QuizStateType.inProgress));
      var quiz = await _quizRepository.getQuiz(event.quizId);
      emit(state.copyOf(
        state: QuizStateType.success,
        quiz: quiz,
      ));
    } on DioError catch (e) {
      emit(state.copyOf(
        state: QuizStateType.failure,
        failureMessage: e.response!.data['msg'],
      ));
    }
  }

  Future<void> _onCompleted(QuizCompleted event, Emitter emit) async {
    try {
      emit(state.copyOf(state: QuizStateType.inProgress));
      var result = await _quizRepository.checkResult(
        event.quizId,
        event.completedQuiz,
      );
      emit(state.copyOf(
        state: QuizStateType.success,
        result: result,
      ));
    } on DioError catch (e) {
      emit(state.copyOf(
        state: QuizStateType.failure,
        failureMessage: e.response!.data['msg'],
      ));
    }
  }
}
