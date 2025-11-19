import 'package:dio/dio.dart';
import 'package:login/data/response/login_response.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'login_service.g.dart';

const String baseUrl = "http://192.168.1.100:8080";

@RestApi(baseUrl: baseUrl)
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl, ParseErrorLogger
  errorLogger}) =
  _LoginService;

  @POST('/customers/login')
  Future<HttpResponse<LoginResponse>> login(@Field('email') String email,
      @Field('password') String password,);
}
