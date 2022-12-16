import 'package:equatable/equatable.dart';
import 'package:etiquette/domain/model/question_option.dart';

class Question extends Equatable {
  final int id;
  final String text;
  final List<QuestionOption> options;

  const Question({
    required this.id,
    required this.text,
    required this.options,
  });

  @override
  List<Object?> get props => [ id, text, options, ];
}
