import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CharityPage extends StatelessWidget{
  const CharityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A81FF),
            Color(0xFF899CFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 130),
                SvgPicture.asset('assets/charity_line_1.svg'),
                const SizedBox(height: 100),
                SvgPicture.asset('assets/charity_line_2.svg'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 69.25,
                left: 24.25,
                right: 21,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28.25),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.75),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Кто нуждается в вашей помощи?',
                            style:  TextStyle(
                              color: Colors.white,
                              fontFamily: 'RF Dewi',
                              fontSize: 25.22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 34),
                        SizedBox(
                          width: 327,
                          height: 68,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: const Text(
                              'Множество людей без возможности обучения мечтают об этом!',
                              style: TextStyle(
                                color: Color(0xFF3E3E3E),
                                fontFamily: 'Geometria',
                                fontSize: 15.78,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 33.83),
                        const Text(
                          'В лбой момент ты можешь помочь нуждающимся, давая им возможность пробиться в свет.\n\n'
                              'Все деньги идут исключительно нуждающимся, приложение не берёт процентов!\n\n'
                              'Реквезиты предоставлены ниже.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Geometria',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 75.17),
                        SizedBox(
                          width: 322,
                          height: 58,
                          //TODO: add blurry border
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.09,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            child: const Text(
                              '0000 0000 0000 0000',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Geometria',
                                fontSize: 20.96,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        const Center(
                          child: Text(
                            'NAME SURNAME',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Geometria',
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}