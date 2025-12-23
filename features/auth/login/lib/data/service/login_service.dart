import 'package:dio/dio.dart';
import 'package:login/data/response/login_response.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'login_service.g.dart';

const String baseUrl =
    "https://api.mockfly.dev/mocks/85d6edfc-934c-4e5a-bb0e-2b887c3811ca";

@RestApi(baseUrl: baseUrl)
abstract class LoginService {
  factory LoginService(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger errorLogger,
  }) = _LoginService;

  @POST('/customers/login')
  // it returns a future that will eventually contain an HTTP response with a LoginResponse object.
  Future<HttpResponse<LoginResponse>> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}
