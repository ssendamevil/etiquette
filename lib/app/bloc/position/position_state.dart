part of 'position_bloc.dart';

enum PositionStateType {
  initial,
  inProgress,
  success,
  failure,
}

class PositionState extends Equatable {
  final PositionStateType state;
  final List<Position>? positions;
  final String? failureMessage;

  const PositionState({
    this.state = PositionStateType.initial,
    this.positions,
    this.failureMessage,
  });

  PositionState copyOf({
    PositionStateType? state,
    List<Position>? positions,
    String? failureMessage,
  }){
    return PositionState(
      state: state ?? this.state,
      positions: positions ?? this.positions,
      failureMessage: failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        state,
        positions,
        failureMessage,
      ];
}
