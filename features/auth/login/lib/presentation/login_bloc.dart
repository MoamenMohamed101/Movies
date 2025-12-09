import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/data/request/login_request.dart';
import 'package:login/domain/usecase/login_usecase.dart';
import 'package:login/presentation/login_event.dart';
import 'package:login/presentation/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<UserNameChanged>((event, emit) {
      final userNameError = validateUserName(event.userName);
      emit(
        LoginInvalidCredentials(
          userNameError: userNameError,
          passwordError: (state is LoginInvalidCredentials)
              ? state.passwordError
              : null,
        ),
      );
    });
    on<PasswordChanged>((event, emit) {
      final passwordError = validatePassword(event.password);
      emit(
        LoginInvalidCredentials(
          userNameError: (state is LoginInvalidCredentials)
              ? state.userNameError
              : null,
          passwordError: passwordError,
        ),
      );
    });
    on<LoginButtonPressed>((event, emit) async {
      final userNameError = validateUserName(event.userName);
      final passwordError = validatePassword(event.password);

      if (userNameError == null && passwordError == null) {
        emit(LoginLoading());
        final loginRequest = LoginRequest("moamen@gmail.com", "123456");
        final result = await loginUseCase.execute(loginRequest);
        result.fold(
          (failure) {
            emit(LoginError(failure.message));
          },
          (loginModel) {
            print(loginModel.name);
            emit(LoginSuccess());
          },
        );
      }
    });
  }
}

String? validateUserName(String userName) {
  if (userName.isEmpty) {
    return "username can't be empty";
  } else if (userName.length < 3) {
    return "username must be at least 3 chars";
  }
  return null;
}

String? validatePassword(String password) {
  if (password.isEmpty) {
    return "username can't be empty";
  } else if (password.length < 6) {
    return "username must be at least 6 chars";
  }
  return null;
}
