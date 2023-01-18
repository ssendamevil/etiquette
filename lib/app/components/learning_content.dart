import 'package:etiquette/app/bloc/learning/learning_bloc.dart';
import 'package:etiquette/app/components/employer_module_card.dart';
import 'package:etiquette/app/components/module_card.dart';
import 'package:etiquette/app/page/lessons_list_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LearningContent extends StatelessWidget {
  final LearningState state;
  final LearningBloc _bloc;
  late int positionTypeId;

  LearningContent(this._bloc, this.state, {Key? key}) : super(key: key) {
    positionTypeId = BoxHelper.getPositionType()!;
  }

  @override
  Widget build(BuildContext context) {
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
                        'Level ${index + 1}',
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/lock.svg'),
                          const SizedBox(width: 13),
                          Text(
                            'Level ${index + 1}',
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
                          'Section ${sectionIndex + 1}: ${section.title}',
                          style: TextStyle(
                            fontFamily: 'Geometria',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: (section.isUnlocked)
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFA0A3BD),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var module = section.modules[index];
                          if (positionTypeId == 1) {
                            return ModuleCard(module, () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LessonsListPage(
                                      module.id,
                                      module.quizId,
                                      sectionIndex + 1,
                                      index + 1,
                                      module.isTestPassed),
                                ),
                              );
                              _bloc.add(LearningStartedEvent(
                                  BoxHelper.getPositionId()!));
                            });
                          }
                          return EmployerModuleCard(
                            module,
                            sectionIndex,
                            index,
                            () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LessonsListPage(
                                      module.id,
                                      module.quizId,
                                      sectionIndex + 1,
                                      index + 1,
                                      module.isTestPassed),
                                ),
                              );
                              _bloc.add(LearningStartedEvent(
                                  BoxHelper.getPositionId()!));
                            },
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
      separatorBuilder: (context, index) => const SizedBox(height: 40),
      itemCount: state.levels!.length,
    );
  }
}
