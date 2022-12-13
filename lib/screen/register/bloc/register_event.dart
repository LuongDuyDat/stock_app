import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEmailChange extends RegisterEvent {
  const RegisterEmailChange({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [email];
}

class RegisterNameChange extends RegisterEvent {
  const RegisterNameChange({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [name];
}

class RegisterUserNameChange extends RegisterEvent {
  const RegisterUserNameChange({
    required this.username,
  });

  final String username;

  @override
  List<Object?> get props => [username];
}

class RegisterPasswordChange extends RegisterEvent {
  const RegisterPasswordChange({
    required this.password,
  });

  final String password;

  @override
  List<Object?> get props => [password];
}

class RegisterSubmit extends RegisterEvent {
  const RegisterSubmit();
}

class RegisterChangeRegisterStatus extends RegisterEvent {
  const RegisterChangeRegisterStatus();
}