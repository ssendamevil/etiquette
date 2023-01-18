import 'package:etiquette/app/page/charity_page.dart';
import 'package:etiquette/app/page/learning_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CharityDialog {
  final BuildContext _context;
  BuildContext? _dismissedContext;
  late bool notShowAgain;

  CharityDialog(this._context) {
    notShowAgain = false;
  }

  Future<bool> show() async {
    try {
      showGeneralDialog(
          context: _context,
          pageBuilder: (context, animation, secondaryAnimation) {
            return StatefulBuilder(builder: (context, setState) {
              _dismissedContext = context;
              return Padding(
                padding: const EdgeInsets.only(
                  top: 231,
                  left: 31,
                  right: 31,
                  bottom: 213,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: hide,
                                      child: const Icon(
                                        Icons.close,
                                        color: Color(0xFF2F2F2F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset('assets/charity.svg'),
                          const SizedBox(height: 17.17),
                          const Text(
                            'Who needs your help?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF2F2F2F),
                              fontFamily: 'Geometria',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Some text that will encourage people to go to charity tab by pressing a button',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFFA0A3BD),
                              fontFamily: 'Geometria',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                checkColor: Colors.white,
                                activeColor: const Color(0xFF6A81FF),
                                value: notShowAgain,
                                onChanged: (value) =>
                                    setState(() => notShowAgain = value!),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                'Don\'t show again',
                                style: TextStyle(
                                  color: Color(0xFF2F2F2F),
                                  fontFamily: 'Geometria',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFE7B638),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await Navigator.of(_dismissedContext!).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CharityPage()));
                                    hide();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14.5,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'Charity',
                                      textAlign: TextAlign.center,
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
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          });
    } catch (e) {
      return false;
    }
    return true;
  }

  void hide() {
    if (notShowAgain) {
      BoxHelper.saveCharityShow(notShowAgain);
    }
    Navigator.of(_dismissedContext!).pop();
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (context) => const LearningPage(),
    ));
  }
}
