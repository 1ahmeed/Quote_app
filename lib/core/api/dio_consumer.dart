import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/api/status_code.dart';
import 'package:quotes/core/errors/exceptions.dart';
import 'package:quotes/injection_container.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    dio.interceptors.add(di.serviceLocator<AppInterceptors>());
    if (kDebugMode) {
      dio.interceptors.add(di.serviceLocator<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response = await dio.get(path, queryParameters: query);
      return jsonDecode(response.data.toString());
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? query,
        bool formDataIsEnable=false,
        Map<String, dynamic>? body}) async {
    try {
      final response = await dio.post(path, queryParameters: query,
          data: formDataIsEnable? FormData.fromMap(body!):body);
      return jsonDecode(response.data.toString());
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? query, Map<String, dynamic>? body}) async {
    try {
      final response = await dio.put(path, queryParameters: query, data: body);
      return jsonDecode(response.data.toString());
    } on DioException catch (error) {
      _handleDioException(error);
    }
  }

  dynamic _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            return const BadRequestException();
          case StatusCode.unAuthorized:
            return const UnauthorizedException();
          case StatusCode.forbidden:
            return const UnauthorizedException();
          case StatusCode.notFound:
            return const NotFoundException();
          case StatusCode.conflict:
            return const InternalServerErrorException();
        }
        break;

      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();
    }
  }
}
