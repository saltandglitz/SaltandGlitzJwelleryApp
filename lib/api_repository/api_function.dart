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
      printError("Context is null");
      return Future.error('Context is null');
    }

    try {
      Response response; // This will hold the full Response object

      if (isGet) {
        response = await HttpUtil(token!, isLoading, context).get(apiName);
      } else {
        // Determine the type of the parameters being sent
        if (params is Map) {
          // If params is a Map, we are sending JSON
          response = await HttpUtil(token!, isLoading, context).post(
            apiName,
            data: params, // Send the Map directly as JSON
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                // Explicitly setting the content type for JSON
                'authorization': token.isNotEmpty ? token : '',
              },
            ),
          );
        } else if (params is FormData) {
          // If params is FormData, we're sending multipart/form-data
          response = await HttpUtil(token!, isLoading, context).post(
            apiName,
            data: params, // Send FormData as multipart
            options: Options(
              headers: {
                'Content-Type': 'multipart/form-data',
                // Explicitly setting the content type for multipart
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
      printError('Error in API Call: $e');
      rethrow; // Propagate the error
    }
  }
}
