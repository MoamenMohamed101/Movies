import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class UserNameChanged extends LoginEvent {
  final String userName;
  const UserNameChanged(this.userName);
  @override
  List<Object?> get props => [userName];
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class LoginButtonPressed extends LoginEvent {
  final String userName;
  final String password;
  const LoginButtonPressed({required this.userName, required this.password});
  @override
  List<Object?> get props => [userName, password];
}
