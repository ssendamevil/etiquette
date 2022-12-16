import 'package:dio/dio.dart';
import 'package:etiquette/domain/model/attachment.dart';
import 'package:etiquette/domain/model/lesson.dart';
import 'package:etiquette/domain/model/level.dart';
import 'package:etiquette/domain/model/module.dart';
import 'package:etiquette/domain/model/position.dart';
import 'package:etiquette/domain/model/section.dart';

class LearningNetworkProvider {
  final Dio _dio;

  const LearningNetworkProvider(this._dio);

  Future<Lesson> getLessonById(int lessonId) async {
    var response = await _dio.get(
      'api/learning/get_lesson/',
      queryParameters: {
        'id': lessonId,
      },
    );

    return _parseLesson(response.data);
  }

  Future<List<Lesson>> getLessons(int moduleId) async {
    var response = await _dio.get(
      'api/learning/get_lessons_by_module/',
      queryParameters: {
        'module_id': moduleId,
      },
    );

    return (response.data as List).map((e) => _parseLesson(e)).toList();
  }

  Future<List<Level>> getLevels(int positionId) async {
    var response = await _dio.get(
      'api/learning/get_levels/',
      queryParameters: {
        'position_id': positionId,
      },
    );

    return (response.data as List).map((e) => _parseLevel(e)).toList();
  }

  Future<List<Position>> getPositions(int typeId) async {
    var response = await _dio.get(
      'learning/get_positions',
      queryParameters: {
        'type_id': typeId,
      },
    );

    return (response.data as List).map((e) => _parsePosition(e)).toList();
  }

  Lesson _parseLesson(dynamic e) {
    return Lesson(
      id: e['id'],
      title: e['title'],
      videoPreview: e['video_preview'],
      videoFile: e['video_file'],
      content: e['content'],
      shortDescription: e['short_description'],
      attachmentsNumber: e['attachments_number'],
      isComplete: e['is_complete'],
      isFavourite: e['is_favourite'],
      time: e['time'],
      attachments:
          (e['attachments'] as List).map((e) => _parseAttachment(e)).toList(),
    );
  }

  Attachment _parseAttachment(dynamic e) {
    return Attachment(
      id: e['id'],
      title: e['title'],
      link: e['link'],
    );
  }

  Level _parseLevel(dynamic e) {
    return Level(
      id: e['id'],
      sections: (e['sections'] as List).map((e) => _parseSection(e)).toList(),
      isUnlocked: e['isUnlocked'],
    );
  }

  Section _parseSection(dynamic e){
    return Section(
      id: e['id'],
      modules: (e['modules'] as List).map((e) => _parseModule(e)).toList(),
      title: e['title'],
    );
  }

  Module _parseModule(dynamic e){
    return Module(
      id: e['id'],
      shortDescription: e['short_description'],
      quizId: e['quiz_id'],
      isTestPassed: e['is_test_passed'],
      isUnlocked: e['is_unlocked'],
      lessonsNumber: e['lessons_number'],
      lessonsPassed: e['lessons_passed'],
    );
  }

  Position _parsePosition(dynamic e){
    return Position(e['id'], e['name']);
  }
}
