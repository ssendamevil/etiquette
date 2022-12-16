import 'package:etiquette/domain/model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final int number;

  const LessonCard(this.lesson, this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 134,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: //NetworkImage(lesson.videoPreview),
                //TODO: get image from network
                AssetImage(lesson.videoPreview),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 25,
            right: 20,
            bottom: 13,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '• ${lesson.time} минут',
                        style: const TextStyle(
                          color: Color(0xFF6A81FF),
                          fontFamily: 'Geometria',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '• ${lesson.attachmentsNumber} файла',
                        style: const TextStyle(
                          color: Color(0xFF6A81FF),
                          fontFamily: 'Geometria',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  (!lesson.isComplete!)
                      ? SvgPicture.asset('assets/star.svg')
                      : SvgPicture.asset('assets/star_marked.svg'),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '№$number. ${lesson.title}',
                  style: const TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontFamily: 'Geometria',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                lesson.shortDescription!,
                style: const TextStyle(
                  color: Color(0xFF2F2F2F),
                  fontFamily: 'Geometria',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 11,
          child: Container(
            decoration: BoxDecoration(
              color: (lesson.isComplete!) ? const Color(0xFFE7B638) : null,
              gradient: (!lesson.isComplete!)
                  ? const LinearGradient(
                      colors: [
                        Color(0xFF6A81FF),
                        Color(0xFF899CFF),
                      ],
                    )
                  : null,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
