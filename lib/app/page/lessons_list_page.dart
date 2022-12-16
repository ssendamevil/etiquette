import 'package:etiquette/app/bloc/lessons_list/lessons_list_bloc.dart';
import 'package:etiquette/app/components/lesson_card.dart';
import 'package:etiquette/app/page/lesson_page.dart';
import 'package:etiquette/app/page/quiz_page.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonsListPage extends StatelessWidget {
  final int moduleId;
  final int quizId;
  final int sectionNumber;
  final int moduleNumber;

  const LessonsListPage(
    this.moduleId,
    this.quizId,
    this.sectionNumber,
    this.moduleNumber, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LessonsListBloc>(
      create: (context) => LessonsListBloc(context.read<LearningRepository>()),
      child: LessonsListView(moduleId, quizId, sectionNumber, moduleNumber),
    );
  }
}

class LessonsListView extends StatefulWidget {
  final int moduleId;
  final int quizId;
  final int sectionNumber;
  final int moduleNumber;

  const LessonsListView(
    this.moduleId,
    this.quizId,
    this.sectionNumber,
    this.moduleNumber, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LessonsListViewState();
  }
}

class LessonsListViewState extends State<LessonsListView> {
  late LessonsListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LessonsListBloc>()
      ..add(LessonsPageStarted(widget.moduleId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 23.25,
              right: 20.75,
              top: 64,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  radius: 17.5,
                  child: Image.asset('assets/arrow_back.png'),
                ),
                Text(
                  'Раздел ${widget.sectionNumber}-${widget.moduleNumber}',
                  style: const TextStyle(
                    fontFamily: 'Geometria',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2F2F2F),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  radius: 17.5,
                  child: Image.asset('assets/question.png'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22.18),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              child: BlocBuilder<LessonsListBloc, LessonsListState>(
                builder: (context, state) {
                  switch (state.state) {
                    case LessonsListStateType.initial:
                      return Container();
                    case LessonsListStateType.inProgress:
                      return Container();
                    case LessonsListStateType.failure:
                      return Center(
                        child: Text(state.failureMessage!),
                      );
                    case LessonsListStateType.success:
                      var lessons = state.lessons;
                      return ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          if (index == lessons!.length) {
                            return Column(
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => QuizPage(
                                              widget.quizId,
                                            ),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFFE7B638),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    LessonPage(lessons[index].id, index + 1),
                              ),
                            ),
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
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: lessons!.length + 1,
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
