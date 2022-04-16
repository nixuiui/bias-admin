import 'dart:convert';
import 'dart:io';

import 'package:bias_admin/helpers/network/logging_interceptor.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
class NetworkService {
  static NetworkService get to => Get.find();
  
  static const int requestTimeOut = 30 * 1000;

  late Dio dio;

  NetworkService() {
    dio = Dio(_baseOptions);
    if (kDebugMode) {
      dio.interceptors.add(LoggingInterceptor());
    }
  }

  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: 'https://bias-dev.herokuapp.com/api/v1',
    connectTimeout: requestTimeOut,
    receiveTimeout: requestTimeOut,
    responseType: ResponseType.json,
    followRedirects: true,
  );

  Map<String, dynamic> headersRequest() {
    final token = AuthService.to.token.value;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };
  }

  Map<String, dynamic> headersRequestMultipart() {
    final token = AuthService.to.token.value;
    return {
      HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType,
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  /// Send Http GET Request
  Future<Response> get({
    required String url,
    Map<String, dynamic>? parameters,
    Function(int, int)? onReceiveProgress,
    ResponseType? responseType,
  }) async {
    return await _safeFetch(
      () => dio.get(
        url,
        queryParameters: parameters ?? {},
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: headersRequest(),
          responseType: responseType,
        ),
      ),
    );
  }

  /// Send Http POST Request
  Future<Response> post({
    required String url,
    dynamic data,
    Function(int, int)? onReceiveProgress,
    Function(int, int)? onSendProgress,
    ResponseType? responseType,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeFetch(
      () => dio.post(
        url,
        data: jsonEncode(data),
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: Options(
          responseType: responseType,
          headers: headersRequest(),
          contentType: 'application/json'
        ),
        queryParameters: queryParameters
      ),
    );
  }

  /// Send Http POST Request
  Future<Response> postMultipart({
    required String url,
    dynamic data,
  }) async {
    return await _safeFetch(
      () => dio.post(
        url,
        data: data,
        options: Options(
          headers: headersRequestMultipart()
        ),
      ),
    );
  }

  /// Send Http PUT Request
  Future<Response> put({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeFetch(
      () => dio.put(
        url,
        data: data,
        options: Options(headers: headersRequest()),
        queryParameters: queryParameters,
      ),
    );
  }
  
  /// Send Http PATCH Request
  Future<Response> patch({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _safeFetch(
      () => dio.patch(
        url,
        data: data,
        options: Options(headers: headersRequest()),
        queryParameters: queryParameters,
      ),
    );
  }

  /// Send Http DELETE Request
  Future<Response> delete({
    required String url,
    dynamic data,
    required Map<String, dynamic> parameters,
  }) async {
    return await _safeFetch(
      () => dio.delete(
        url,
        data: data,
        queryParameters: parameters,
        options: Options(
          headers: headersRequest(),
        ),
      ),
    );
  }

  /// Send Http DELETE Request
  Future<Response> deleteMultipart({
    required String url,
    dynamic data,
    required int contentLength,
  }) async {
    return await _safeFetch(
      () => dio.delete(
        url,
        data: data,
        options: Options(
          headers: headersRequestMultipart(),
        ),
      ),
    );
  }

  /// Send Http UPLOAD Request
  Future<Response> upload({
    required String url,
    required FormData formData,
  }) async {
    return await _safeFetch(() => dio.post(url,
        data: formData, options: Options(headers: headersRequest())));
  }

  /// Send Http download Request
  Future<Response> download({
    required String url,
    required String savePath,
    required ProgressCallback onReceiveProgress,
  }) async {
    return await _safeFetch(
      () => dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: headersRequest()),
      ),
    );
  }

  /// Wrap fetch (get/post) request with try-catch
  /// & error handling
  Future<Response> _safeFetch(Future<Response> Function() tryFetch) async {
    try {
      print('_safeFetch: _safeFetch');
      final response = await tryFetch();
      print('_safeFetch: $response');
      print('_safeFetch: ${response.realUri}');
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException('Unable to process the data');
    } on DioError catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}