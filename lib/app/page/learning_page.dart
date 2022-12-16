import 'package:etiquette/app/bloc/learning/learning_bloc.dart';
import 'package:etiquette/app/components/module_card.dart';
import 'package:etiquette/app/page/lessons_list_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LearningBloc>(
      create: (context) => LearningBloc(
        context.read<LearningRepository>(),
      ),
      child: const LearningView(),
    );
  }
}

class LearningView extends StatefulWidget {
  const LearningView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LearningViewState();
  }
}

class LearningViewState extends State<LearningView> {
  late LearningBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LearningBloc>()
      ..add(LearningStartedEvent(BoxHelper.getPositionId()!));
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
              top: 65,
              bottom: 36,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  radius: 17.5,
                  child: Image.asset('assets/star_black.png'),
                ),
                const Text(
                  'Обучение',
                  style: TextStyle(
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
          Expanded(
            child: BlocBuilder<LearningBloc, LearningState>(
              builder: (context, state) {
                switch (state.state) {
                  case LearningStateType.initial:
                    return Container();
                  case LearningStateType.inProgress:
                    return Container();
                  case LearningStateType.failure:
                    return Center(
                      child: Text(state.failureMessage!),
                    );
                  case LearningStateType.success:
                    return ListView.separated(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var level = state.levels![index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 17,
                          ),
                          child: Column(
                            children: [
                              (level.isUnlocked)
                                  ? Center(
                                      child: Text(
                                        'Уровень ${index + 1}',
                                        style: const TextStyle(
                                          fontFamily: 'Geometria',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF6A81FF),
                                        ),
                                      ),
                                    )
                                  // ? Row(
                                  //     children: [
                                  //       const Divider(
                                  //         indent: 0,
                                  //         endIndent: 24,
                                  //         thickness: 1,
                                  //         color: Color(0xFF6A81FF),
                                  //       ),
                                  //       Text(
                                  //         'Уровень ${index + 1}',
                                  //         style: const TextStyle(
                                  //           fontFamily: 'Geometria',
                                  //           fontSize: 20,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: Color(0xFF6A81FF),
                                  //         ),
                                  //       ),
                                  //       const Divider(
                                  //         indent: 23,
                                  //         endIndent: 0,
                                  //         thickness: 1,
                                  //         color: Color(0xFF6A81FF),
                                  //       ),
                                  //     ],
                                  //   )
                                  : Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/lock.svg'),
                                          const SizedBox(width: 13),
                                          Text(
                                            'Уровень ${index + 1}',
                                            style: const TextStyle(
                                              fontFamily: 'Geometria',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFA0A3BD),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              // : Row(
                              //     children: [
                              //       const Divider(
                              //         indent: 0,
                              //         endIndent: 23,
                              //         thickness: 1,
                              //         color: Color(0xFFA0A3BD),
                              //       ),
                              //       SvgPicture.asset('assets/lock.svg'),
                              //       const SizedBox(width: 13),
                              //       Text(
                              //         'Уровень ${index + 1}',
                              //         style: const TextStyle(
                              //           fontFamily: 'Geometria',
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.w500,
                              //           color: Color(0xFFA0A3BD),
                              //         ),
                              //       ),
                              //       const Divider(
                              //         indent: 20,
                              //         endIndent: 0,
                              //         thickness: 1,
                              //         color: Color(0xFFA0A3BD),
                              //       ),
                              //     ],
                              //   ),
                              const SizedBox(height: 20),
                              ListView.separated(
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, sectionIndex) {
                                  var section = level.sections[sectionIndex];
                                  return Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Раздел ${sectionIndex + 1}: ${section.title}',
                                          style: TextStyle(
                                            fontFamily: 'Geometria',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: (level.isUnlocked)
                                                ? const Color(0xFF2F2F2F)
                                                : const Color(0xFFA0A3BD),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ListView.separated(
                                        padding: const EdgeInsets.all(0),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          var module = section.modules[index];
                                          return ModuleCard(
                                            module,
                                            () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonsListPage(
                                                        module.id,
                                                        module.quizId,
                                                        sectionIndex + 1,
                                                        index + 1),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 15),
                                        itemCount: section.modules.length,
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 40),
                                itemCount: level.sections.length,
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 40),
                      itemCount: state.levels!.length,
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
