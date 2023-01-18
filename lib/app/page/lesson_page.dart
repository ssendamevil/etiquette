import 'package:chewie/chewie.dart';
import 'package:etiquette/app/bloc/lesson/lesson_bloc.dart';
import 'package:etiquette/domain/repository/learning_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class LessonPage extends StatelessWidget {
  final int lessonId;
  final int lessonNumber;

  const LessonPage(
    this.lessonId,
    this.lessonNumber, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LessonBloc>(
      create: (context) => LessonBloc(context.read<LearningRepository>()),
      child: LessonView(lessonId, lessonNumber),
    );
  }
}

class LessonView extends StatefulWidget {
  final int lessonId;
  final int lessonNumber;

  const LessonView(
    this.lessonId,
    this.lessonNumber, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LessonViewState();
  }
}

class LessonViewState extends State<LessonView> {
  late LessonBloc _bloc;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LessonBloc>()
      ..add(LessonStartedEvent(widget.lessonId));
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 65),
          Padding(
            padding: const EdgeInsets.only(
              left: 23.25,
              right: 20.75,
              bottom: 24.545,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  radius: 17.5,
                  child: Image.asset('assets/arrow_back.png'),
                ),
                Text(
                  'Lesson ${widget.lessonNumber}',
                  style: const TextStyle(
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
          BlocBuilder<LessonBloc, LessonState>(
            builder: (context, state) {
              switch (state.state) {
                case LessonStateType.initial:
                  return Container();
                case LessonStateType.inProgress:
                  return Container();
                case LessonStateType.failure:
                  return Center(
                    child: Text(state.failureMessage!),
                  );
                case LessonStateType.success:
                  var lesson = state.lesson!;
                  if (lesson.videoFile != null) {
                    _videoPlayerController =
                        VideoPlayerController.network(lesson.videoFile!);
                    _chewieController = ChewieController(
                      videoPlayerController: _videoPlayerController,
                      looping: false,
                      autoPlay: false,
                      autoInitialize: true,
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 56,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              lesson.title,
                              style: const TextStyle(
                                color: Color(0xFF6A81FF),
                                fontFamily: 'Geometria',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.84),
                        SizedBox(
                          width: 341,
                          height: 250,
                          child: ListView(
                            padding: const EdgeInsets.all(0),
                            children: [
                              Text(
                                lesson.content!,
                                style: const TextStyle(
                                  color: Color(0xFF2F2F2F),
                                  fontFamily: 'Geometria',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        (lesson.videoFile != null)
                            ? const SizedBox(height: 25.295)
                            : Container(),
                        (lesson.videoFile != null)
                            ? Center(
                                child: SizedBox(
                                  width: 338,
                                  height: 189,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                        Chewie(controller: _chewieController),
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        (lesson.attachments!.isNotEmpty)
                            ? const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Probably, some materials to download:',
                                  style: TextStyle(
                                    color: Color(0xFF2F2F2F),
                                    fontFamily: 'Geometria',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Container(),
                        (lesson.attachments!.isNotEmpty)
                            ? const SizedBox(height: 23)
                            : Container(),
                        (lesson.attachments!.isNotEmpty)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  right: 3,
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (context, index) => Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            lesson.attachments![index].title,
                                            style: const TextStyle(
                                              color: Color(0xFFE7B638),
                                              fontFamily: 'Geometria',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          radius: 18,
                                          child: Image.asset(
                                              'assets/download.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 15),
                                  itemCount: lesson.attachments!.length,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
