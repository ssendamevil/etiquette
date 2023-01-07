import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/app/bloc/exception/exception_extensions.dart';
import 'package:etiquette/domain/model/lesson.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LearningRepository _learningRepository;

  LessonBloc(this._learningRepository) : super(const LessonState()) {
    on<LessonStartedEvent>(_onStarted);
  }

  Future<void> _onStarted(LessonStartedEvent event, Emitter emit) async {
    try {
      emit(state.copyOf(state: LessonStateType.inProgress));
      var lesson = await _learningRepository.getLessonById(event.lessonId);
      emit(state.copyOf(
        state: LessonStateType.success,
        lesson: lesson,
      ));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: LessonStateType.failure,
        failureMessage: e.parseMessage(),
      ));
    }
  }
}
