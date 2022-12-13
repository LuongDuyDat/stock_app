import 'package:equatable/equatable.dart';

enum RegisterStatus {initial, loading, success, failure}


class RegisterState extends Equatable {
  const RegisterState({
    this.email = '',
    this.name = '',
    this.username = '',
    this.password = '',
    this.registerStatus = RegisterStatus.initial,
  });

  final String email;
  final String name;
  final String username;
  final String password;
  final RegisterStatus registerStatus;

  RegisterState copyWith({
    String Function()? username,
    String Function()? name,
    String Function()? email,
    String Function()? password,
    RegisterStatus Function()? registerStatus,
  }) {
    return RegisterState(
      username: username != null ? username() : this.username,
      name: name != null ? name() : this.name,
      email: email != null ? email() : this.email,
      password: password != null ? password() : this.password,
      registerStatus: registerStatus != null ? registerStatus() : this.registerStatus,
    );

  }

  @override
  List<Object?> get props => [
    name,
    username,
    email,
    password,
    registerStatus,
  ];
}