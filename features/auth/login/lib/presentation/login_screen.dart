import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/usecase/login_usecase.dart';
import 'package:login/presentation/login_bloc.dart';
import 'package:login/presentation/login_event.dart';
import 'package:login/presentation/login_state.dart';
import 'package:movie_app/di/injection.dart';

class LoginScreen extends StatelessWidget {
  final loginUseCase = getIt<LoginUsecase>();
  final TextEditingController _userEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      // BlocProvider creates the LoginBloc and makes it available to all widgets underneath it in the "widget tree".
      body: BlocProvider(
        create: (context) => LoginBloc(loginUseCase),
        // The "Rebuilder": Whenever the BLoC says emit(NewState), the builder function triggers, and the UI updates automatically.
        // Dynamic UI: If state has a userNameError, the TextField shows red text.
        // If the state were LoginLoading you could use this state variable to show a spinner instead of the button.
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsetsDirectional.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _userEditingController,
                    onChanged: (value) {
                      // context.read: To tell the BLoC that something happened, the UI "Adds an Event".
                      // Every time you type a letter, the UI sends a UserNameChanged event.
                      // The BLoC processes it, checks if it's valid, and emits a state back, which BlocBuilder uses to show/hide the error message.
                      context.read<LoginBloc>().add(UserNameChanged(value));
                    },
                    decoration: InputDecoration(
                      labelText: "username",
                      errorText: state is LoginInvalidCredentials
                          ? state.userNameError
                          : null,
                    ),
                  ),
                  TextField(
                    controller: _passwordEditingController,
                    onChanged: (value) {
                      context.read<LoginBloc>().add(PasswordChanged(value));
                    },
                    decoration: InputDecoration(
                      labelText: "password",
                      errorText: state is LoginInvalidCredentials
                          ? state.passwordError
                          : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // When the button is clicked, it gathers the text from the controllers and sends the LoginButtonPressed event.
                      final userName = _userEditingController.text;
                      final password = _passwordEditingController.text;
                      context.read<LoginBloc>().add(
                        LoginButtonPressed(
                          userName: userName,
                          password: password,
                        ),
                      );
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/*

Summary of the Cycle:
UI Interaction: User types "abc" in the username field.
Event Sent: onChanged calls add(UserNameChanged("abc")).
BLoC Logic: The BLoC calculates that "abc" is valid and emits(LoginInvalidCredentials(userNameError: null)).
UI Update: BlocBuilder receives the state. Since userNameError is null, it removes the red error text from the TextField.

*/
