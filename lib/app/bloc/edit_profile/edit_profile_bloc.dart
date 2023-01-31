import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/app/bloc/exception/exception_extensions.dart';
import 'package:etiquette/domain/model/user.dart';
import 'package:etiquette/domain/repository/user_repository.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository _userRepository;

  EditProfileBloc(this._userRepository) : super(EditProfileState()) {
    on<EditProfilePressed>(_onEdited);
  }

  Future<void> _onEdited(EditProfilePressed event, Emitter emit) async {
    try {
      emit(state.copyOf(state: EditProfileStateType.inProgress));
      await _userRepository.editUser(event.user);
      emit(state.copyOf(state: EditProfileStateType.success));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: EditProfileStateType.failure,
        failureMessage: e.parseMessage(),
      ));
    }
  }
}
