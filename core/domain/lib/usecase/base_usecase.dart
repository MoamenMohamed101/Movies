import 'package:dartz/dartz.dart';
import 'package:domain/model/failure.dart';

abstract class BaseUsecase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
