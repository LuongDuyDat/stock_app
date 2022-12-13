import 'package:equatable/equatable.dart';

enum LoginStatus {initial, loading, success, failure}


class LoginState extends Equatable {
  const LoginState({
    this.username = '',
    this.password = '',
    this.loginStatus = LoginStatus.initial,
  });

  final String username;
  final String password;
  final LoginStatus loginStatus;

  LoginState copyWith({
    String Function()? username,
    String Function()? password,
    LoginStatus Function()? loginStatus,
  }) {
    return LoginState(
      username: username != null ? username() : this.username,
      password: password != null ? password() : this.password,
      loginStatus: loginStatus != null ? loginStatus() : this.loginStatus,
    );

  }

  @override
  List<Object?> get props => [
    username,
    password,
    loginStatus,
  ];
}