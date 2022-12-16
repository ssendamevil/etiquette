import 'package:equatable/equatable.dart';

class QuestionOption extends Equatable{

  final int id;
  final String text;

  const QuestionOption({ required this.id, required this.text });

  @override
  List<Object?> get props => [ id, text, ];

}