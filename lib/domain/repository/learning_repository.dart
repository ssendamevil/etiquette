import 'package:etiquette/domain/model/lesson.dart';
import 'package:etiquette/domain/model/level.dart';
import 'package:etiquette/domain/model/position.dart';

abstract class LearningRepository{

  Future<List<Position>> getPositions(int typeId);
  Future<List<Level>> getLevels(int positionId);
  Future<List<Lesson>> getLessons(int moduleId);
  Future<Lesson> getLessonById(int lessonId);

}