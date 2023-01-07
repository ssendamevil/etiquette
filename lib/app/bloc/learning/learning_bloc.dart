import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/app/bloc/exception/exception_extensions.dart';
import 'package:etiquette/domain/model/level.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';

part 'learning_event.dart';
part 'learning_state.dart';

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final LearningRepository _learningRepository;

  LearningBloc(this._learningRepository)
      : super(const LearningState(state: LearningStateType.initial)) {
    on<LearningStartedEvent>(_onStarted);
  }

  Future<void> _onStarted(LearningStartedEvent event, Emitter emit) async {
    try {
      emit(state.copyOf(state: LearningStateType.inProgress));
      var levels = await _learningRepository.getLevels(event.positionId);
      emit(state.copyOf(
        state: LearningStateType.success,
        levels: levels,
      ));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: LearningStateType.failure,
        failureMessage: e.parseMessage(),
      ));
    }
  }
}
