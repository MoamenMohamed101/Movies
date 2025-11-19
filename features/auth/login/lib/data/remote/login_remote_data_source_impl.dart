import 'package:dartz/dartz.dart';
import 'package:data/network/api_safe_call.dart';
import 'package:data/network_info/network_info.dart';
import 'package:domain/model/failure.dart';
import 'package:login/data/remote/login_remote_data_source.dart';
import 'package:login/data/request/login_request.dart';
import 'package:login/data/response/login_response.dart';
import 'package:login/data/service/login_service.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final LoginService _loginService;
  final NetworkInfo _networkInfo;

  LoginRemoteDataSourceImpl(this._loginService, this._networkInfo);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    return safeApiCall(_networkInfo, () async {
      final response = await _loginService.login(
        request.email,
        request.password,
      );
      return response.data;
    });
  }
}
