import 'package:data/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  final String baseUrl;
  final String accessToken;
  final String language;

  DioFactory({
    required this.baseUrl,
    required this.accessToken,
    required this.language,
  });

  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: accessToken,
      defaultLanguage: language,
      clientId: "app_client_id",
    };

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
        ),
      );
    }
    return dio;
  }
}
