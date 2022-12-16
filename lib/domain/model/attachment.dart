import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final int id;
  final String title;
  final String link;

  const Attachment({
    required this.id,
    required this.title,
    required this.link,
  });

  @override
  List<Object?> get props => [ id, title, link ];
}
