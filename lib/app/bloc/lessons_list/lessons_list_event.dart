part of 'lessons_list_bloc.dart';

abstract class LessonsListEvent extends Equatable {
  const LessonsListEvent();
}

class LessonsPageStarted extends LessonsListEvent {
  final int moduleId;

  const LessonsPageStarted(this.moduleId);

  @override
  List<Object?> get props => [ moduleId ];
}
