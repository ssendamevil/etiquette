part of 'lesson_bloc.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();
}

class LessonStartedEvent extends LessonEvent{

  final int lessonId;

  const LessonStartedEvent(this.lessonId);

  @override
  List<Object?> get props => [ lessonId ];
}
