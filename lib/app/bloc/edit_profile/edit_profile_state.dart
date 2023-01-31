part of 'edit_profile_bloc.dart';

enum EditProfileStateType { initial, inProgress, success, failure }

class EditProfileState extends Equatable {

  EditProfileStateType state;
  String? failureMessage;

  EditProfileState({
    this.state = EditProfileStateType.initial,
    this.failureMessage,
  });

  EditProfileState copyOf({
    required EditProfileStateType state,
    String? failureMessage,
  }) {
    return EditProfileState(
      state: state,
      failureMessage: failureMessage
    );
  }

  @override
  List<Object?> get props => [ state, failureMessage ];
}
