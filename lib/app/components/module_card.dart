import 'package:etiquette/domain/model/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef ModuleClicked = Function();

class ModuleCard extends StatelessWidget {
  final Module module;
  final ModuleClicked onClicked;

  const ModuleCard(this.module, this.onClicked, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 97,
          height: 97,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (!module.isUnlocked)
                  ? Colors.white
                  : (module.isTestPassed)
                      ? const Color(0xFFE7B638)
                      : null,
              gradient: (module.isUnlocked && !module.isTestPassed)
                  ? const LinearGradient(colors: [
                      Color(0xFF6A81FF),
                      Color(0xFF899CFF),
                    ])
                  : null,
            ),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: (!module.isUnlocked)
                  ? SvgPicture.asset('assets/lock.svg')
                  : Text(
                      '${(module.lessonsPassed / module.lessonsNumber * 100).floor()}%',
                      style: TextStyle(
                        fontFamily: 'Geometria',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: (module.isTestPassed)
                            ? Colors.white
                            : const Color(0xFF2F2F2F),
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: (module.isUnlocked)
                ? () => onClicked.call()
                : () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          module.shortDescription,
                          style: TextStyle(
                            color: (module.isUnlocked)
                                ? const Color(0xFF2F2F2F)
                                : const Color(0xFFA0A3BD),
                            fontFamily: 'Geometria',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${module.lessonsPassed} из ${module.lessonsNumber}',
                        style: TextStyle(
                          fontFamily: 'Geometria',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: (module.isUnlocked)
                              ? const Color(0xFF2F2F2F)
                              : const Color(0xFFA0A3BD),
                        ),
                      ),
                      (module.isUnlocked)
                          ? (module.isTestPassed)
                              ? const Text(
                                  'Тест пройден',
                                  style: TextStyle(
                                    fontFamily: 'Geometria',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFE7B638),
                                  ),
                                )
                              : const Text(
                                  'Тест не пройден',
                                  style: TextStyle(
                                    fontFamily: 'Geometria',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFA0A3BD),
                                  ),
                                )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
