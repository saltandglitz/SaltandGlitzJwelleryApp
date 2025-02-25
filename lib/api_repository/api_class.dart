import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

import '../local_storage/pref_manager.dart';
import '../view/components/common_message_show.dart';
import 'loading.dart';

class HttpUtil {
  factory HttpUtil(String token, bool isLoading, BuildContext context) =>
      _instance(token, isLoading, context);

  static HttpUtil _instance(token, isLoading, context) =>
      HttpUtil._internal(token: token, isLoading: isLoading, context: context);

//     Comments
  late Dio dio;
  CancelToken cancelToken = CancelToken();

  // String apiUrl = LocalStrings.baseUrl;
  BuildContext? context;
  PrefManager getStorage = PrefManager();

  HttpUtil._internal(
      {String? token, bool? isLoading, required BuildContext context}) {
    token = PrefManager.getString(getStorage.token);

    BaseOptions options = BaseOptions(
      // baseUrl: apiUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      headers: {
        // 'key': LocalStrings.apiKey,
        // 'token': token,
      },
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (isLoading!) {
          Loading.show();
        }
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        if (isLoading!) {
          Loading.dismiss();
        }
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        if (isLoading!) {
          Loading.dismiss();
        }
        onError(createErrorEntity(e), context);
        return handler.next(e); //continue
      },
    ));
  }

// On Error....
  void onError(ErrorEntity eInfo, BuildContext context) {
    printActionError(
        "error.code -> ${eInfo.code}, error.message -> ${eInfo.message}");
    if (eInfo.message.isNotEmpty) {
      showSnackBar(message: eInfo.message, context: context);
    }
  }

  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "Request to server was cancelled");
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -2, message: "Connection timeout with server");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -3, message: "Send timeout in connection with server");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -4, message: "Receive timeout in connection with server");
      case DioErrorType.response:
        {
          try {
            int errCode = error.response != null ? error.response!.statusCode! : 00;

            // Now handle the response body correctly if it's a Map
            String errorMessage = '';
            if (error.response != null && error.response!.data != null) {
              var data = error.response!.data;
              if (data is Map<String, dynamic>) {
                // Extract a meaningful error message from the Map if it exists
                errorMessage = data['message'] ?? 'Unknown error occurred'; // Adjust this to match your API's response format
              } else if (data is String) {
                errorMessage = data;
              }
            }

            switch (errCode) {
              case 401:
                return ErrorEntity(code: errCode, message: "Permission denied");
              case 403:
                return ErrorEntity(code: errCode, message: "Server refuses to execute");
              case 405:
                return ErrorEntity(code: errCode, message: "Request method is forbidden");
              case 502:
                return ErrorEntity(code: errCode, message: "Invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "Server hangs");
              case 505:
                return ErrorEntity(code: errCode, message: "HTTP protocol requests are not supported");
              default:
                return ErrorEntity(code: errCode, message: '');
            }
          } on Exception catch (_) {
            return ErrorEntity(code: 00, message: "Unknown mistake");
          }
        }
      case DioErrorType.other:
        if (error.message.contains("SocketException")) {
          return ErrorEntity(code: -5, message: "Your internet is not available, please try again later");
        } else if (error.message.contains("Software caused connection abort")) {
          return ErrorEntity(code: -6, message: "Your internet is not available, please try again later");
        }
        return ErrorEntity(code: -7, message: "Oops something went wrong");
      default:
        return ErrorEntity(code: -8, message: "Oops something went wrong");
    }
  }

  void cancelRequests() {
    cancelToken.cancel("cancelled");
  }

  /// restful get
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = true,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// restful post
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// restful put
  Future put(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// restful delete
  Future delete(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// restful patch
  Future patch(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// restful post form
  Future postForm(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }

  /// restful post Stream
  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    requestOptions.headers!.addAll({
      Headers.contentLengthHeader: dataLength.toString(),
    });
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
