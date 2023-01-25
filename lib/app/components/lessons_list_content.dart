import 'package:etiquette/app/bloc/learning/learning_bloc.dart';
import 'package:etiquette/app/bloc/lessons_list/lessons_list_bloc.dart';
import 'package:etiquette/app/components/lesson_card.dart';
import 'package:etiquette/app/page/lesson_page.dart';
import 'package:etiquette/app/page/quiz_page.dart';
import 'package:etiquette/domain/model/lesson.dart';
import 'package:flutter/material.dart';

class LessonsListContent extends StatelessWidget {
  final int moduleId;
  final LessonsListBloc _bloc;
  final List<Lesson> lessons;
  final int quizId;
  final bool isTestPassed;

  const LessonsListContent(
    this.moduleId,
    this._bloc,
    this.lessons,
    this.quizId,
    this.isTestPassed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        if (index == lessons.length) {
          return Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (lessons[0].isQuizUnlocked! && !isTestPassed)
                          ? () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => QuizPage(
                                    quizId,
                                  ),
                                ),
                              )
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFE7B638),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.5,
                        ),
                        child: Text(
                          'Пройти тест',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RF Dewi',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 65),
            ],
          );
        }
        return ElevatedButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LessonPage(lessons[index].id, index + 1),
              ),
            );
            _bloc.add(LessonsPageStarted(moduleId));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(0),
          ),
          child: LessonCard(lessons[index], index + 1),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: lessons.length + 1,
    );
  }
}
