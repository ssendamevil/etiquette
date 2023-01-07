import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/app/bloc/exception/exception_extensions.dart';
import 'package:etiquette/domain/model/position.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';

part 'position_event.dart';

part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  final LearningRepository _learningRepository;

  PositionBloc(this._learningRepository)
      : super(const PositionState(state: PositionStateType.initial)) {
    on<PositionStartedEvent>(_onStarted);
  }

  Future<void> _onStarted(PositionStartedEvent event, Emitter emit) async {
    try {
      emit(state.copyOf(state: PositionStateType.inProgress));
      var positions = await _learningRepository.getPositions(event.typeId);
      emit(state.copyOf(
        state: PositionStateType.success,
        positions: positions,
      ));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: PositionStateType.failure,
        failureMessage: e.parseMessage(),
      ));
    }
  }
}
