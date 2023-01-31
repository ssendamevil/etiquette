part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class EditProfilePressed extends EditProfileEvent{

  final User user;

  const EditProfilePressed(this.user);

  @override
  List<Object?> get props => [user];
}
