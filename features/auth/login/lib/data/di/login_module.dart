import 'package:data/network_info/network_info.dart';
import 'package:data/network_info/network_info_impl.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:login/data/remote/login_remote_data_source.dart';
import 'package:login/data/remote/login_remote_data_source_impl.dart';
import 'package:login/data/repository/login_repository_impl.dart';
import 'package:login/data/service/login_service.dart';
import 'package:login/domain/repository/login_repository.dart';
import 'package:login/domain/usecase/login_usecase.dart';

@module
abstract class LoginModule {
  @lazySingleton
  LoginService provideLoginService(Dio dio) {
    return LoginService(dio);
  }

  NetworkInfo provideNetworkInfo() => NetworkInfoImpl();

  @lazySingleton
  LoginRemoteDataSource provideLoginRemoteDataSource(
    LoginService service,
    NetworkInfo networkInfo,
  ) {
    return LoginRemoteDataSourceImpl(service, networkInfo);
  }

  @lazySingleton
  LoginRepository provideLoginRepository(
    LoginRemoteDataSource remoteDataSource,
  ) {
    return LoginRepositoryImpl(remoteDataSource);
  }

  @lazySingleton
  LoginUsecase provideLoginUseCase(LoginRepository loginRepository) {
    return LoginUsecase(loginRepository);
  }
}
