import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etiquette/app/bloc/exception/exception_extensions.dart';
import 'package:etiquette/data/db/box_helper.dart';
import 'package:etiquette/data/db/entity/token_entity.dart';
import 'package:etiquette/domain/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  late String phone;
  late int code;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthCodeEnteredEvent>(_onCodeSent);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter emit) async {
    try {
      emit(state.copyOf(state: AuthStateType.isProgress, isLogin: true));
      await _authRepository.verifyPhone(event.phone);
      phone = event.phone;
      emit(state.copyOf(state: AuthStateType.success));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: AuthStateType.initial,
        failureMessage: e.parseMessage(),
      ));
    }
  }

  Future<void> _onRegister(AuthRegisterEvent event, Emitter emit) async {
    try {
      emit(state.copyOf(state: AuthStateType.isProgress, isLogin: false));
      await _authRepository.verifyPhone(event.phone);
      phone = event.phone;
      emit(state.copyOf(state: AuthStateType.success));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: AuthStateType.initial,
        failureMessage: e.parseMessage(),
      ));
    }
  }

  Future<void> _onCodeSent(AuthCodeEnteredEvent event, Emitter emit) async {
    try {
      late TokenEntity tokens;
      emit(state.copyOf(state: AuthStateType.isProgress));
      if (event.isLogin) {
        tokens = await _authRepository.register(phone, event.code);
      } else {
        tokens = await _authRepository.register(phone, event.code);
      }
      BoxHelper.saveToken(tokens);
      emit(state.copyOf(state: AuthStateType.codeAccepted));
    } on Exception catch (e) {
      emit(state.copyOf(
        state: AuthStateType.success,
        failureMessage: e.parseMessage(),
      ));
    }
  }
}
