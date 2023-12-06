import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sul_sul/utils/api/uris.dart';
import 'package:sul_sul/utils/auth/jwt_storage.dart';

class ApiServerConnector {
  late Dio dio;

  ApiServerConnector(String baseUrl) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
    );
    dio = Dio(options);
    setInterceptors();
  }

  void setInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!excludeAuthenticationUris.contains(options.path)) {
            String jwt = await jwtStorage.get();
            options.headers['Authorization'] = 'Bearer $jwt';
          }
          log("REQUEST :: ${options.method} ${options.path} :: DATA: ${jsonEncode(options.data)}");
          return handler.next(options);
        },
        onResponse: (options, handler) {
          log("RESPONSE :: ${options.statusCode} = ${options.data}");
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          final body = e.response?.data as Map<String, dynamic>;
          log("'${e.requestOptions.path}' call failed [${e.response?.statusCode}] message: ${body['message']}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) {
    return dio.post(path, queryParameters: queryParameters, data: data);
  }

  Future<Response<T>> put<T>(String path,
      {Map<String, dynamic>? queryParameters, dynamic data}) {
    return dio.put(path, queryParameters: queryParameters, data: data);
  }

  Future<Response<T>> delete<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    return dio.delete(path, queryParameters: queryParameters);
  }
}

final localServer = ApiServerConnector("http://localhost:8080");
final androidLocalServer = ApiServerConnector("http://10.0.2.2:8080");
final sulsulServer = ApiServerConnector(
    "http://sulsul-env.eba-gvmvk4bq.ap-northeast-2.elasticbeanstalk.com/");
