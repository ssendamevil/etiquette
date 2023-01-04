import 'package:etiquette/app/page/learning_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:etiquette/domain/model/position.dart';
import 'package:flutter/material.dart';

class PositionButton extends StatelessWidget {
  final Position position;

  const PositionButton(this.position, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6A81FF),
            Color(0xFF899CFF),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ElevatedButton(
        onPressed: () {
          BoxHelper.savePositionId(position.id);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LearningPage(),
          ));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        child: Text(
          'I am ${position.name}',
          style: const TextStyle(
            fontFamily: 'Geometria',
            fontSize: 21.91,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
