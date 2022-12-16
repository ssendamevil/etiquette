part of 'position_bloc.dart';

abstract class PositionEvent extends Equatable {
  const PositionEvent();
}

class PositionStartedEvent extends PositionEvent{

  final int typeId;

  const PositionStartedEvent(this.typeId);

  @override
  List<Object?> get props => [ typeId ];

}