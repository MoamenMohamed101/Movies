import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? userNameError;
  final String? passwordError;
  final String? errorMessage;

  const LoginState({this.userNameError, this.passwordError, this.errorMessage});

  LoginState copyWith({
    String? userNameError,
    String? passwordError,
    String? errorMessage,
  }) {
    return LoginState(
      userNameError: userNameError ?? this.userNameError,
      passwordError: passwordError ?? this.passwordError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [userNameError, passwordError, errorMessage];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginInvalidCredentials extends LoginState {
  final String? userNameError;
  final String? passwordError;

  const LoginInvalidCredentials({this.userNameError, this.passwordError})
    : super(userNameError: userNameError, passwordError: passwordError);
}

class LoginError extends LoginState {
  final String errorMessage;

  const LoginError(this.errorMessage) : super(errorMessage: errorMessage);
}
