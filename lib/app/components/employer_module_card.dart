import 'package:etiquette/domain/model/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef ModuleClicked = Function();

class EmployerModuleCard extends StatelessWidget {
  final Module module;
  final int sectionNumber;
  final int moduleNumber;
  final ModuleClicked onClicked;

  const EmployerModuleCard(
    this.module,
    this.sectionNumber,
    this.moduleNumber,
    this.onClicked, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: (module.isUnlocked) ? () => onClicked.call() : () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 91,
                  height: 97,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      gradient: (sectionNumber % 2 == 0)
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF6A81FF),
                                Color(0xFF899CFF),
                              ],
                            )
                          : null,
                      color: (sectionNumber % 2 == 1)
                          ? const Color(0xFFE7B638)
                          : null,
                    ),
                    child: SvgPicture.asset(
                      (sectionNumber % 2 == 0)
                          ? (moduleNumber % 2 == 0)
                              ? 'assets/module_line_1.svg'
                              : 'assets/module_line_2.svg'
                          : (moduleNumber % 2 == 0)
                              ? 'assets/module_line_3.svg'
                              : 'assets/module_line_4.svg',
                      fit: BoxFit.none,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                Expanded(
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
