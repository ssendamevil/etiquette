part of 'learning_bloc.dart';

enum LearningStateType { initial, inProgress, failure, success }

class LearningState extends Equatable {
  final LearningStateType state;
  final List<Level>? levels;
  final String? failureMessage;

  const LearningState({
    this.state = LearningStateType.initial,
    this.levels,
    this.failureMessage,
  });

  LearningState copyOf({
    LearningStateType? state,
    List<Level>? levels,
    String? failureMessage,
  }){
    return LearningState(
      state: state ?? this.state,
      levels: levels ?? this.levels,
      failureMessage: failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    state,
    levels,
    failureMessage,
  ];
}
