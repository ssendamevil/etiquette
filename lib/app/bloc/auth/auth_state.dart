part of 'auth_bloc.dart';

enum AuthStateType { initial, isProgress, success, failure, codeAccepted }

class AuthState extends Equatable {

  final AuthStateType state;
  final bool? isLogin;
  final String? failureMessage;

  const AuthState({
    this.state = AuthStateType.initial,
    this.isLogin,
    this.failureMessage,
  });

  AuthState copyOf({
    AuthStateType? state,
    bool? isLogin,
    String? failureMessage,
  }){
    return AuthState(
      state: state ?? this.state,
      isLogin: isLogin ?? this.isLogin,
      failureMessage: failureMessage
    );
  }

  @override
  List<Object?> get props => [ state, isLogin, failureMessage, ];
}

