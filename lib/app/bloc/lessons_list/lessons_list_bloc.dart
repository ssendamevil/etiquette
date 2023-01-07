import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/app/bloc/exception/exception_extensions.dart';
import 'package:etiquette/domain/model/lesson.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';

part 'lessons_list_event.dart';
part 'lessons_list_state.dart';

class LessonsListBloc extends Bloc<LessonsListEvent, LessonsListState> {
  final LearningRepository _learningRepository;

  LessonsListBloc(this._learningRepository)
      : super(const LessonsListState(state: LessonsListStateType.initial)) {
    on<LessonsPageStarted>(_onStarted);
  }

  Future<void> _onStarted(LessonsPageStarted event, Emitter emit) async {
    try {
      emit(state.copyOf(state: LessonsListStateType.inProgress));
      var lessons = await _learningRepository.getLessons(event.moduleId);
      emit(state.copyOf(
        state: LessonsListStateType.success,
        lessons: lessons,
      ));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: LessonsListStateType.failure,
        failureMessage: e.parseMessage(),
      ));
    }
  }
}
