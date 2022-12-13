import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginUserNameChange extends LoginEvent {
  const LoginUserNameChange({
    required this.username,
  });

  final String username;

  @override
  List<Object?> get props => [username];
}

class LoginPasswordChange extends LoginEvent {
  const LoginPasswordChange({
    required this.password,
  });

  final String password;

  @override
  List<Object?> get props => [password];
}

class LoginSubmit extends LoginEvent {
  const LoginSubmit();
}