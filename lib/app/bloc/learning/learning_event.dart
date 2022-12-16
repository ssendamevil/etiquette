part of 'learning_bloc.dart';

abstract class LearningEvent extends Equatable {
  const LearningEvent();
}

class LearningStartedEvent extends LearningEvent{

  final int positionId;

  const LearningStartedEvent(this.positionId);

  @override
  List<Object?> get props => [ positionId ];

}