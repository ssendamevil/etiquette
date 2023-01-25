import 'dart:async';

import 'package:async/async.dart';
import 'package:etiquette/app/bloc/quiz/quiz_bloc.dart';
import 'package:etiquette/app/components/charity_dialog.dart';
import 'package:etiquette/app/page/learning_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:etiquette/domain/repository/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:format/format.dart';

class QuizPage extends StatelessWidget {
  final int quizId;

  const QuizPage(this.quizId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (context) => QuizBloc(context.read<QuizRepository>()),
      child: QuizView(quizId),
    );
  }
}

class QuizView extends StatefulWidget {
  final int quizId;

  const QuizView(this.quizId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QuizViewState();
  }
}

class QuizViewState extends State<QuizView> {
  late QuizBloc _bloc;
  late int currentQuestion;
  late int timerMinutes;
  late int timerSeconds;
  late int timerMilliseconds;
  List<List<bool>>? checkboxVars;
  List<int>? answers;
  late CharityDialog _charityDialog;
  bool? charityShow;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<QuizBloc>();
    currentQuestion = 0;
    timerMinutes = 15;
    timerSeconds = 0;
    timerMilliseconds = 0;
    _charityDialog = CharityDialog(context);
    charityShow = BoxHelper.getCharityShow();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                switch (state.state) {
                  case QuizStateType.initial:
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 66,
                        right: 17,
                        left: 17,
                        top: 93,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              format('{:02d}:{:02d}:{:02d}', timerMinutes,
                                  timerSeconds, timerMilliseconds),
                              style: const TextStyle(
                                color: Color(0xFF2F2F2F),
                                fontFamily: 'Geometria',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 152.83),
                            SvgPicture.asset('assets/quiz_info.svg'),
                            const SizedBox(height: 19.885),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 26),
                              child: Text(
                                'На прохождения теста дается 15 минут!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF2F2F2F),
                                  fontFamily: 'Geometria',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 28.34),
                            const Text(
                              'Также при попытке свернуть приложение тест автоматически завершится',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFA0A3BD),
                                fontFamily: 'Geometria',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => _bloc
                                            .add(QuizStarted(widget.quizId)),
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
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF6A81FF),
                                              Color(0xFF899CFF),
                                            ],
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            primary: Colors.transparent,
                                            elevation: 0,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 14.5,
                                            ),
                                            child: Text(
                                              'Вернуться назад',
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  case QuizStateType.inProgress:
                    return Container();
                  case QuizStateType.failure:
                    return Center(
                      child: Text(state.failureMessage!),
                    );
                  case QuizStateType.success:
                    var quiz = state.quiz;
                    answers ??= List.filled(quiz!.questions.length, 0);
                    checkboxVars ??= List.generate(
                      quiz!.questions.length,
                      (i) => List.generate(
                        quiz.questions[i].options.length,
                        (j) => false,
                      ),
                    );
                    if (currentQuestion == quiz!.questions.length) {
                      timer!.cancel();
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 66,
                          right: 17,
                          left: 17,
                          top: 206,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              (state.result! >= 80)
                                  ? SvgPicture.asset('assets/quiz_success.svg')
                                  : SvgPicture.asset('assets/quiz_failure.svg'),
                              const SizedBox(height: 14),
                              Text(
                                '${state.result}%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: (state.result! >= 80)
                                      ? const Color(0xFFE7B638)
                                      : const Color(0xFFE73838),
                                  fontFamily: 'Geometria',
                                  fontSize: 44.27,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 54),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 26),
                                child: Text(
                                  (state.result! >= 80)
                                      ? 'Тест успешно пройден'
                                      : 'Тест не пройден',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF2F2F2F),
                                    fontFamily: 'Geometria',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 26),
                                child: Text(
                                  (state.result! >= 80)
                                      ? 'Поздравляем! Вы успешно завершили тест и теперь можете просматривать следующие этапы'
                                      : 'Вы допустили одну или несколько ошибок. Перепройдите тест или повторите изученный материал',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFA0A3BD),
                                    fontFamily: 'Geometria',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (charityShow == null ||
                                                  charityShow == false) {
                                                _charityDialog.show();
                                              }
                                              // Navigator.of(context)
                                              //     .push(MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       const LearningPage(),
                                              // ));
                                            },
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
                                                'Вернуться на главную',
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
                                    //const SizedBox(height: 66),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (timer == null){
                      _timer(quiz.questions.length);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 66,
                        right: 16.31,
                        left: 15.69,
                        top: 67,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            // Row(
                            //   children: [
                            //     ListView.separated(
                            //       shrinkWrap: true,
                            //       scrollDirection: Axis.horizontal,
                            //       physics: const NeverScrollableScrollPhysics(),
                            //       itemBuilder: (context, index) => SizedBox(
                            //         width: (MediaQuery.of(context).size.width -
                            //             32) /
                            //             quiz!.questions.length *
                            //             0.9,
                            //         height: 3,
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //             color: (index <= currentQuestion)
                            //                 ? const Color(0xFFE7B638)
                            //                 : const Color(0xFF6A81FF),
                            //             borderRadius: BorderRadius.circular(5),
                            //           ),
                            //         ),
                            //       ),
                            //       separatorBuilder: (context, index) =>
                            //           SizedBox(
                            //             width: (MediaQuery.of(context).size.width -
                            //                 32) /
                            //                 quiz!.questions.length *
                            //                 0.1,
                            //           ),
                            //       itemCount: quiz!.questions.length,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(height: 28.545),
                            Text(
                              format('{:02d}:{:02d}:{:02d}', timerMinutes,
                                  timerSeconds, timerMilliseconds),
                              style: const TextStyle(
                                color: Color(0xFF2F2F2F),
                                fontFamily: 'Geometria',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 57.09),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Вопрос №${currentQuestion + 1}',
                                style: const TextStyle(
                                  color: Color(0xFF2F2F2F),
                                  fontFamily: 'Geometria',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 29),
                                child: Text(
                                  quiz.questions[currentQuestion].text,
                                  style: const TextStyle(
                                    color: Color(0xFF2F2F2F),
                                    fontFamily: 'Geometria',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                top: 30,
                              ),
                              itemBuilder: (context, index) => CheckboxListTile(
                                  title: Text(
                                    quiz.questions[currentQuestion]
                                        .options[index].text,
                                    style: const TextStyle(
                                      color: Color(0xFF002033),
                                      fontFamily: 'Geometria',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xFF6A81FF),
                                  value: checkboxVars![currentQuestion][index],
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxVars![currentQuestion] =
                                          List.generate(
                                        quiz.questions[currentQuestion].options
                                            .length,
                                        (index) => false,
                                      );
                                      checkboxVars![currentQuestion][index] =
                                          true;
                                      answers![currentQuestion] = quiz
                                          .questions[currentQuestion]
                                          .options[index]
                                          .id;
                                    });
                                  }),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 24),
                              itemCount: quiz
                                  .questions[currentQuestion].options.length,
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: (answers![currentQuestion] !=
                                                0)
                                            ? () => setState(
                                                  () {
                                                    if (currentQuestion ==
                                                        quiz.questions.length -
                                                            1) {
                                                      _bloc.add(QuizCompleted(
                                                        widget.quizId,
                                                        answers,
                                                      ));
                                                    }
                                                    currentQuestion += 1;
                                                  },
                                                )
                                            : null,
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
                                            'Далее',
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
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF6A81FF),
                                              Color(0xFF899CFF),
                                            ],
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: (currentQuestion != 0)
                                              ? () => setState(
                                                    () => currentQuestion -= 1,
                                                  )
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            primary: Colors.transparent,
                                            elevation: 0,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 14.5,
                                            ),
                                            child: Text(
                                              'Назад',
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _timer(int questionsNumber) {
    if (timerMinutes == 0 && timerSeconds == 0 && timerMilliseconds == 0){
      return;
    }
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (timerMinutes == 0 && timerSeconds == 0 && timerMilliseconds == 0) {
        _bloc.add(QuizCompleted(
          widget.quizId,
          answers,
        ));
        setState(() => currentQuestion = questionsNumber);
        timer.cancel();
      } else {
        setState((){
          timerMilliseconds -= 1;
          if (timerMilliseconds == -1) {
            timerMilliseconds = 99;
            timerSeconds -= 1;
            if (timerSeconds == -1) {
              timerSeconds = 59;
              timerMinutes -= 1;
              if (timerMinutes == -1) {
                timerMinutes = 0;
              }
            }
          }
        });
      }
    });
  }
}
