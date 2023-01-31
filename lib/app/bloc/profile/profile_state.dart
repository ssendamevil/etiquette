part of 'profile_bloc.dart';

enum ProfileStateType { initial, inProgress, success, failure }

class ProfileState extends Equatable {
  ProfileStateType state;
  User? user;
  String? failureMessage;

  ProfileState({
    this.state = ProfileStateType.initial,
    this.user,
    this.failureMessage,
  });

  ProfileState copyOf({
    required ProfileStateType state,
    User? user,
    String? failureMessage,
  }) {
    return ProfileState(
      state: state,
      user: user ?? this.user,
      failureMessage: failureMessage
    );
  }

  @override
  List<Object?> get props => [ state, user, failureMessage ];
}
