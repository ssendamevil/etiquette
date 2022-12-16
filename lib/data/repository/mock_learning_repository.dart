import 'package:etiquette/domain/model/attachment.dart';
import 'package:etiquette/domain/model/lesson.dart';
import 'package:etiquette/domain/model/module.dart';
import 'package:etiquette/domain/model/level.dart';
import 'package:etiquette/domain/model/position.dart';
import 'package:etiquette/domain/model/section.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';

class MockLearningRepository extends LearningRepository {
  @override
  Future<List<Position>> getPositions(int typeId) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => List.of([
        const Position(1, 'няня'),
        const Position(2, 'официант'),
      ]),
    );
  }

  @override
  Future<List<Level>> getLevels(int positionId) async {
    return Future.delayed(
        const Duration(seconds: 2),
        () => List.of([
              Level(
                id: 1,
                isUnlocked: true,
                sections: List.of([
                  Section(
                    id: 1,
                    title: 'Название раздела',
                    modules: List.of([
                      const Module(
                        id: 1,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 7,
                        lessonsNumber: 7,
                        isUnlocked: true,
                        isTestPassed: true,
                        quizId: 1,
                      ),
                      const Module(
                        id: 2,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 4,
                        lessonsNumber: 8,
                        isUnlocked: true,
                        isTestPassed: false,
                        quizId: 2,
                      ),
                    ]),
                  ),
                  Section(
                    id: 2,
                    title: 'Название раздела',
                    modules: List.of([
                      const Module(
                        id: 3,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 2,
                        lessonsNumber: 8,
                        isUnlocked: true,
                        isTestPassed: false,
                        quizId: 3,
                      ),
                      const Module(
                        id: 4,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 4,
                      ),
                    ]),
                  ),
                ]),
              ),
              Level(
                id: 2,
                isUnlocked: false,
                sections: List.of([
                  Section(
                    id: 3,
                    title: 'Название раздела',
                    modules: List.of([
                      const Module(
                        id: 5,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 5,
                      ),
                      const Module(
                        id: 6,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 6,
                      ),
                    ]),
                  ),
                  Section(
                    id: 4,
                    title: 'Название раздела',
                    modules: List.of([
                      const Module(
                        id: 7,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 7,
                      ),
                      const Module(
                        id: 8,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 8,
                      ),
                    ]),
                  ),
                ]),
              ),
              Level(
                id: 3,
                isUnlocked: false,
                sections: List.of([
                  Section(
                    id: 5,
                    title: 'Название раздела',
                    modules: List.of([
                      const Module(
                        id: 9,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 9,
                      ),
                      const Module(
                        id: 10,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 10,
                      ),
                    ]),
                  ),
                  Section(
                    id: 6,
                    title: 'Название раздела',
                    modules: List.of([
                      const Module(
                        id: 11,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 11,
                      ),
                      const Module(
                        id: 12,
                        shortDescription:
                            'Краткое описание раздела и что будет в него входить',
                        lessonsPassed: 0,
                        lessonsNumber: 8,
                        isUnlocked: false,
                        isTestPassed: false,
                        quizId: 12,
                      ),
                    ]),
                  ),
                ]),
              ),
            ]));
  }

  @override
  Future<List<Lesson>> getLessons(int moduleId) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => List.of([
        const Lesson(
          id: 1,
          title: 'Название урока',
          shortDescription:
              'Краткое или подробное описание урока, что предстоит узнать человеку',
          time: 15,
          videoPreview: 'assets/test_video_preview.png',
          attachmentsNumber: 2,
          isFavourite: false,
          isComplete: true,
        ),
        const Lesson(
          id: 2,
          title: 'Название урока',
          shortDescription:
              'Краткое или подробное описание урока, что предстоит узнать человеку',
          time: 15,
          videoPreview: 'assets/test_video_preview.png',
          attachmentsNumber: 2,
          isFavourite: false,
          isComplete: false,
        ),
        const Lesson(
          id: 3,
          title: 'Название урока',
          shortDescription:
              'Краткое или подробное описание урока, что предстоит узнать человеку',
          time: 15,
          videoPreview: 'assets/test_video_preview.png',
          attachmentsNumber: 2,
          isFavourite: false,
          isComplete: false,
        ),
      ]),
    );
  }

  @override
  Future<Lesson> getLessonById(int lessonId) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => Lesson(
        id: lessonId,
        title: 'Название урока и что будет в видео ниже',
        videoPreview: 'assets/test_video_preview.png',
        content:
            'Краткое или подробное описание урока, что предстоит узнать человеку и возможно ещё какая-либо необходимая инфрмация. Краткое или подробное описание урока, что предстоит узнать человеку и возможно ещё какая-либо необходимая инфрмация.\n\nКраткое или подробное описание урока, что предстоит узнать человеку и возможно ещё какая-либо необходимая инфрмация. ',
        attachments: List.of(
          [
            const Attachment(
              id: 1,
              title: 'ExampleTitle.pdf',
              link: '',
            ),
            const Attachment(
              id: 2,
              title: 'www.example.pdf',
              link: '',
            ),
          ],
        ),
        videoFile: '',
      ),
    );
  }
}
