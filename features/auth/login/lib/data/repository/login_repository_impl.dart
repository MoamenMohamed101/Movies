import 'package:dartz/dartz.dart';
import 'package:domain/model/failure.dart';
import 'package:login/data/mapper/login_mapper.dart';
import 'package:login/data/remote/login_remote_data_source.dart';
import 'package:login/data/request/login_request.dart';
import 'package:login/domain/model/login_model.dart';
import 'package:login/domain/repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl(this.loginRemoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest request) async {
    final response = await loginRemoteDataSource.login(request);
    return response.fold(
      (failure) => Left(failure),
      (response) => Right(response.toDomain()),
    );
  }
}
