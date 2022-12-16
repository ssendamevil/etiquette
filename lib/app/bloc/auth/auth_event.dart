part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoginEvent extends AuthEvent{

  final String phone;

  const AuthLoginEvent(this.phone);

  @override
  List<Object?> get props => [ phone ];

}

class AuthRegisterEvent extends AuthEvent{

  final String phone;

  const AuthRegisterEvent(this.phone);

  @override
  List<Object?> get props => [ phone ];

}

class AuthCodeEnteredEvent extends AuthEvent{

  final int code;
  final bool isLogin;

  const AuthCodeEnteredEvent(this.code, this.isLogin);

  @override
  List<Object?> get props => [ code, isLogin ];

}