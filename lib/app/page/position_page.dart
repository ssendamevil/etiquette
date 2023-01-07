import 'package:etiquette/app/bloc/position/position_bloc.dart';
import 'package:etiquette/app/components/position_button.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionPage extends StatelessWidget {
  final int positionType;

  const PositionPage(this.positionType, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PositionBloc(
        context.read<LearningRepository>(),
      ),
      child: PositionView(positionType),
    );
  }
}

class PositionView extends StatefulWidget {
  final int positionType;

  const PositionView(this.positionType, {super.key});

  @override
  State<StatefulWidget> createState() {
    return PositionViewState();
  }
}

class PositionViewState extends State<PositionView> {
  late PositionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<PositionBloc>()
      ..add(PositionStartedEvent(widget.positionType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 131),
          const Center(
            child: Text(
              'Welcome to etiq!',
              style: TextStyle(
                color: Color(0xFF2F2F2F),
                fontFamily: 'Geometria',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 60,
            ),
            child: Text(
              'When you behave better than necessary',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6A81FF),
                fontFamily: 'Geometria',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 68),
          BlocBuilder<PositionBloc, PositionState>(
            builder: (context, state) {
              switch (state.state) {
                case PositionStateType.initial:
                  return Container();
                case PositionStateType.inProgress:
                  return Container();
                case PositionStateType.failure:
                  return Center(
                    child: Text(state.failureMessage!),
                  );
                case PositionStateType.success:
                  return Column(
                    children: [
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index == state.positions!.length) {
                            return const Center(
                              child: Text(
                                'Select who you are:',
                                style: TextStyle(
                                  fontFamily: 'Geometria',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF2F2F2F),
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: SizedBox(
                              width: 317,
                              height: 142,
                              child: PositionButton(state.positions![index]),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height:
                              (index + 1 == state.positions!.length) ? 19 : 12,
                        ),
                        itemCount: state.positions!.length + 1,
                      ),
                    ],
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
