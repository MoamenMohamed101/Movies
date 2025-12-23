import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/data/request/login_request.dart';
import 'package:login/domain/usecase/login_usecase.dart';
import 'package:login/presentation/login_event.dart';
import 'package:login/presentation/login_state.dart';

// The LoginBloc is the Main Logic Center (The Kitchen).
// It sits between your UI (The customer ordering food) and your Data (The pantry/suppliers).

// It extends Bloc
// You must define:
//    Input: LoginEvent (What comes in?)
//    Output: LoginState (What goes out?)

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    // Handling Events (on<Event>): This is where you register your "Reaction" logic.
    // You tell the BLoC: "When THIS action happens, run THIS function."

    // Logic: Every time the user types 1 letter, this runs. It checks validateUserName
    // Action: It immediately emits a state. If there is an error (e.g., "username can't be empty"), the UI updates to show that red text.
    on<UserNameChanged>((event, emit) {
      final userNameError = validateUserName(event.userName);
      emit(
        LoginInvalidCredentials(
          userNameError: userNameError,
          // passwordError: (state is LoginInvalidCredentials) ? state.passwordError : null,
          passwordError: null,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = validatePassword(event.password);
      emit(
        LoginInvalidCredentials(
          userNameError: null,
          // userNameError: (state is LoginInvalidCredentials) ? state.userNameError : null,
          passwordError: passwordError,
        ),
      );
    });

    // async: Because calling the server takes time.
    // emit(LoginLoading()): Crucial! The moment the button is pressed, valid or not, we usually want to block interactions. Correction: In the code, it only blocks if validation passes.
    // result.fold(...): This is a functional programming pattern (likely from dartz). It handles the two possible outcomes (Left=Failure, Right=Success) neatly without try/catch blocks.
    on<LoginButtonPressed>((event, emit) async {
      final userNameError = validateUserName(event.userName);
      final passwordError = validatePassword(event.password);

      if (userNameError == null && passwordError == null) {
        emit(LoginLoading());
        final loginRequest = LoginRequest(event.userName, event.password);
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
      } else {
        emit(
          LoginInvalidCredentials(
            userNameError: userNameError,
            passwordError: passwordError,
          ),
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
