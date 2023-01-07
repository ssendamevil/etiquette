import 'package:etiquette/app/bloc/learning/learning_bloc.dart';
import 'package:etiquette/app/components/learning_content.dart';
import 'package:etiquette/app/components/module_card.dart';
import 'package:etiquette/app/page/lessons_list_page.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LearningBloc>(
      create: (context) => LearningBloc(
        context.read<LearningRepository>(),
      ),
      child: const LearningView(),
    );
  }
}

class LearningView extends StatefulWidget {
  const LearningView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LearningViewState();
  }
}

class LearningViewState extends State<LearningView> {
  late LearningBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LearningBloc>()
      ..add(LearningStartedEvent(BoxHelper.getPositionId()!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 23.25,
              right: 20.75,
              top: 65,
              bottom: 36,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  radius: 17.5,
                  child: Image.asset('assets/star_black.png'),
                ),
                const Text(
                  'Learning',
                  style: TextStyle(
                    fontFamily: 'Geometria',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2F2F2F),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  radius: 17.5,
                  child: Image.asset('assets/question.png'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<LearningBloc, LearningState>(
              builder: (context, state) {
                switch (state.state) {
                  case LearningStateType.initial:
                    return Container();
                  case LearningStateType.inProgress:
                    if (state.levels == null){
                      return Container();
                    }
                    return LearningContent(_bloc, state);
                  case LearningStateType.failure:
                    return Center(
                      child: Text(state.failureMessage ?? 'Something went wrong'),
                    );
                  case LearningStateType.success:
                    return LearningContent(_bloc, state);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
