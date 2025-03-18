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
  }) async {
    if (context == null) {
      printActionError("Context is null");
      return Future.error('Context is null');
    }

    try {
      Response response; // This will hold the full Response object

      if (isGet) {
        response = await HttpUtil(token ?? '', isLoading, context).get(apiName);
      } else {
          print("TOKEN 33: $token");
        // Determine the type of the parameters being sent
        if (params is Map) {
          print("TOKEN 22: $token");

          // If params is a Map, we are sending JSON
          response = await HttpUtil(token ?? '', isLoading, context).post(
            apiName,
            data: params, // Send the Map directly as JSON
            options: Options(
              headers: {
                'Content-Type': 'application/json', // Explicitly setting the content type for JSON
                'authorization': token,
              },
            ),
          );
        } else if (params is FormData) {
          print("TOKEN 11: $token");

          // If params is FormData, we're sending multipart/form-data
          response = await HttpUtil(token ?? '', isLoading, context).post(
            apiName,
            data: params, // Send FormData as multipart
            options: Options(
              headers: {
                'Content-Type': 'multipart/form-data', // Explicitly setting the content type for JSON
                'authorization': token,
              },
            ),
          );
        } else {
          // Throw an error if neither Map nor FormData
          throw Exception("Invalid parameters type. Expected Map or FormData.");
        }
      }

      return response; // This is the full Response object
    } catch (e) {
      printActionError('Error in API Call: $e');
      rethrow; // Propagate the error
    }
  }
  // Delete method implementation
  Future<Response> delete({
    required String apiName,
    required BuildContext context,
    FormData? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isLoading = true,
  }) async {
    try {
      if (context == null) {
        printActionError("Context is null");
        return Future.error('Context is null');
      }

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
