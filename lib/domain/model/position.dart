import 'package:equatable/equatable.dart';

class Position extends Equatable{

  final int id;
  final String name;

  const Position(this.id, this.name);

  @override
  List<Object?> get props => [ id, name ];

}