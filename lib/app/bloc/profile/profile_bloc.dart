import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/app/bloc/exception/exception_extensions.dart';
import 'package:etiquette/domain/model/user.dart';
import 'package:etiquette/domain/repository/user_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc(this._userRepository) : super(ProfileState()) {
    on<ProfileStarted>(_onStarted);
  }

  Future<void> _onStarted(ProfileStarted event, Emitter emit) async {
    try {
      emit(state.copyOf(state: ProfileStateType.inProgress));
      var user = await _userRepository.getUserProfile();
      emit(state.copyOf(state: ProfileStateType.success, user: user));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: ProfileStateType.failure,
        failureMessage: e.parseMessage(),
      ));
    }
  }
}
