import 'package:dartz/dartz.dart';
import 'package:data/network_info/network_info.dart';
import 'package:domain/model/failure.dart';
import 'package:domain/model/localised_message.dart';

Future<Either<Failure, T>> safeApiCall<T>(
  NetworkInfo networkInfo,
  Future<T> Function() apiCall,
) async {
  if (await networkInfo.isConnected) {
    try {
      final response = await apiCall();
      return Right(response);
    } catch (error) {
      return Left(
        Failure(0, LocalisedMessage("", "")),
      ); //TODO: Handle different error scenarios
    }
  } else {
    return Left(Failure(-500, LocalisedMessage("Network Error", "")));
  }
}
