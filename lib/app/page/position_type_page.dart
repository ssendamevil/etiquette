import 'package:etiquette/app/page/position_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PositionTypePage extends StatelessWidget {
  const PositionTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 131),
          const Center(
            child: Text(
              'Добро пожаловать!',
              style: TextStyle(
                color: Color(0xFF2F2F2F),
                fontFamily: 'Geometria',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 70,
            ),
            child: Text(
              'Etiquette - когда ведёшь себя лучше, чем необходимо.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6A81FF),
                fontFamily: 'Geometria',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 317,
              height: 142,
              child: Container(
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
                    BoxHelper.savePositionType(1);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PositionPage(1),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Этикет для работника',
                    style: TextStyle(
                      fontFamily: 'Geometria',
                      fontSize: 22.42,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: 317,
              height: 142,
              child: Container(
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
                    BoxHelper.savePositionType(2);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PositionPage(2),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Этикет для работодателя',
                    style: TextStyle(
                      fontFamily: 'Geometria',
                      fontSize: 21.91,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 19),
          const Center(
            child: Text(
              'Выберите, кем вы являетесь:',
              style: TextStyle(
                fontFamily: 'Geometria',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xFF2F2F2F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
