import 'package:dio/dio.dart';
import 'package:domain/model/failure.dart';
import 'package:login/data/request/login_request.dart';
import 'package:login/domain/usecase/login_usecase.dart';
import 'package:movie_app/di/injection.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  Dio dio = Dio();
}

void doLogin() async {
  final loginUsecase = getIt<LoginUsecase>();
  final loginRequest = LoginRequest("moamen@gmail.com", "123456");
  final result = await loginUsecase.execute(loginRequest);
  result.fold(
    (failure) {
      print("Login Failed: ${failure.message}");
    },
    (loginModel) {
      print("Login Success: ${loginModel.name}");
    },
  );
}
