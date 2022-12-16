import 'package:equatable/equatable.dart';
import 'package:etiquette/domain/model/attachment.dart';

class Lesson extends Equatable {
  final int id;
  final String title;
  final String? shortDescription;
  final String? content;
  final int? time;
  final String videoPreview;
  final String? videoFile;
  final List<Attachment>? attachments;
  final int? attachmentsNumber;
  final bool? isFavourite;
  final bool? isComplete;

  const Lesson({
    required this.id,
    required this.title,
    this.shortDescription,
    this.content,
    this.time,
    required this.videoPreview,
    this.videoFile,
    this.attachments,
    this.attachmentsNumber,
    this.isFavourite,
    this.isComplete,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        shortDescription,
        content,
        time,
        videoPreview,
        videoFile,
        attachments,
        isFavourite,
        isComplete,
      ];
}
