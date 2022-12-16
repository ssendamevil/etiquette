//TODO: make DataLearningRepository
import 'package:dio/dio.dart';
import 'package:etiquette/data/provider/learning_network_provider.dart';
import 'package:etiquette/domain/model/lesson.dart';
import 'package:etiquette/domain/model/level.dart';
import 'package:etiquette/domain/model/position.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';

class DataLearningRepository extends LearningRepository {

  final LearningNetworkProvider _learningNetworkProvider;

  DataLearningRepository(Dio dio)
      : _learningNetworkProvider = LearningNetworkProvider(dio);

  @override
  Future<Lesson> getLessonById(int lessonId) {
    return _learningNetworkProvider.getLessonById(lessonId);
  }

  @override
  Future<List<Lesson>> getLessons(int moduleId) {
    return _learningNetworkProvider.getLessons(moduleId);
  }

  @override
  Future<List<Level>> getLevels(int positionId) {
    return _learningNetworkProvider.getLevels(positionId);
  }

  @override
  Future<List<Position>> getPositions(int typeId) {
    return _learningNetworkProvider.getPositions(typeId);
  }


}
