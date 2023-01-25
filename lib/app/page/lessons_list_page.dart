import 'package:etiquette/app/bloc/lessons_list/lessons_list_bloc.dart';
import 'package:etiquette/app/components/lessons_list_content.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonsListPage extends StatelessWidget {
  final int moduleId;
  final int quizId;
  final int sectionNumber;
  final int moduleNumber;
  final bool isTestPassed;

  const LessonsListPage(
    this.moduleId,
    this.quizId,
    this.sectionNumber,
    this.moduleNumber,
    this.isTestPassed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LessonsListBloc>(
      create: (context) => LessonsListBloc(context.read<LearningRepository>()),
      child: LessonsListView(
          moduleId, quizId, sectionNumber, moduleNumber, isTestPassed),
    );
  }
}

class LessonsListView extends StatefulWidget {
  final int moduleId;
  final int quizId;
  final int sectionNumber;
  final int moduleNumber;
  final bool isTestPassed;

  const LessonsListView(
    this.moduleId,
    this.quizId,
    this.sectionNumber,
    this.moduleNumber,
    this.isTestPassed, {
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
                      if (state.lessons == null) {
                        return Container();
                      }
                      return LessonsListContent(
                        widget.moduleId,
                        _bloc,
                        state.lessons!,
                        widget.quizId,
                        widget.isTestPassed,
                      );
                    case LessonsListStateType.failure:
                      return Center(
                        child: Text(state.failureMessage!),
                      );
                    case LessonsListStateType.success:
                      var lessons = state.lessons;
                      return LessonsListContent(
                        widget.moduleId,
                        _bloc,
                        lessons!,
                        widget.quizId,
                        widget.isTestPassed,
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
