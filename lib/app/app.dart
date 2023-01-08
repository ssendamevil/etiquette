import 'package:dio/dio.dart';
import 'package:etiquette/app/page/learning_page.dart';
import 'package:etiquette/app/page/login_page.dart';
import 'package:etiquette/app/page/position_type_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:etiquette/data/repository/data_auth_repository.dart';
import 'package:etiquette/data/repository/data_learning_repository.dart';
import 'package:etiquette/data/repository/data_quiz_repository.dart';
import 'package:etiquette/domain/repository/auth_repository.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';
import 'package:etiquette/domain/repository/quiz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final Dio _dio;
  final bool isMock;

  const App(
    this._dio, {
    Key? key,
    this.isMock = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => DataAuthRepository(_dio),
        ),
        RepositoryProvider<LearningRepository>(
          create: (context) => DataLearningRepository(_dio),
        ),
        RepositoryProvider<QuizRepository>(
          create: (context) => DataQuizRepository(_dio),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppViewState();
  }
}

class AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etiquette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _getFirstPage(),
    );
  }

  Widget _getFirstPage() {
    if (!BoxHelper.hasToken()) {
      return const LoginPage();
    } else if (BoxHelper.getPositionType() == null ||
        BoxHelper.getPositionId() == null) {
      return const PositionTypePage();
    }
    return const PositionTypePage();//return const LearningPage(); TODO: Need to replace
  }
}
