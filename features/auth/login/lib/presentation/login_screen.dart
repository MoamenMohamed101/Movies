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
      body: BlocProvider(
        create: (context) => LoginBloc(loginUseCase),
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
