import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../view/components/common_message_show.dart';
import 'api_class.dart';

class APIFunction {
  Future<Response> apiCall({
    required String apiName,
    required BuildContext? context,
    dynamic params,
    String? token,
    bool isLoading = true,
    bool isGet = false,
    bool isPut = false,
  }) async {
    if (context == null) {
      printActionError("Context is null");
      return Future.error('Context is null');
    }

    try {
      Response response; // This will hold the full Response object

      if (isGet) {
        response = await HttpUtil(token ?? '', isLoading, context).get(apiName);
      } else if (isPut) {
        // Use PUT method for updating data
        response = await HttpUtil(token ?? '', isLoading, context).put(
          apiName,
          data: params, // Send the parameters
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'authorization': token,
            },
          ),
        );
      } else {
        // Default method is POST
        response = await HttpUtil(token ?? '', isLoading, context).post(
          apiName,
          data: params, // Send the parameters
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'authorization': token,
            },
          ),
        );
      }

      return response; // This is the full Response object
    } catch (e) {
      printActionError('Error in API Call: $e');
      rethrow; // Propagate the error
    }
  }

  // DELETE method implementation
  Future<Response> delete({
    required String apiName,
    required BuildContext context,
    FormData? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isLoading = true,
  }) async {
    try {
      Response response; // This will hold the full Response object

      // Send the DELETE request using Dio
      response = await HttpUtil(token ?? '', isLoading, context).delete(
        apiName,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'authorization': token,
          },
        ),
      );

      return response; // This is the full Response object
    } catch (e) {
      printActionError('Error in DELETE API Call: $e');
      rethrow; // Propagate the error
    }
  }
}
