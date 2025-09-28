import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saltandglitz/local_storage/pref_manager.dart';

class Dioclient {
  static Dio? dio;
  Dioclient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.saltandglitz.com',
        // baseUrl: 'https://api.akashch.me/api/v2',
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (Dioclient.dio == null) {
        Dioclient();
      }
      final token = PrefManager.getString('token');

      return await dio!.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: {'Authorization': token}),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        throw Exception('Failed to get data: $e');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      if (Dioclient.dio == null) {
        Dioclient();
      }
      final token = PrefManager.getString('token');

      return await dio!.post(
        path,
        data: data,
        options: Options(headers: {'Authorization': token}),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        throw Exception('Failed to post data: $e');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  static Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      if (Dioclient.dio == null) {
        Dioclient();
      }
      final token = PrefManager.getString('token');

      debugPrint(
        'DioClient PUT request to $path with data: $data and token: $token',
      );
      return await dio!.put(
        path,
        data: data,
        options: Options(headers: {'Authorization': token}),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        throw Exception('Failed to put data: $e');
      }
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  static Future<Response> delete(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      if (Dioclient.dio == null) {
        Dioclient();
      }
      final token = PrefManager.getString('token');

      debugPrint(
        'DioClient DELETE request to $path with data: $data and token: $token',
      );
      return await dio!.delete(
        path,
        data: data,
        options: Options(headers: {'Authorization': token}),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        throw Exception('Failed to delete data: $e');
      }
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  // SOLUTION 1: Return status instead of showing SnackBar directly
  static Future<bool> checkHealth(BuildContext context) async {
    try {
      if (Dioclient.dio == null) {
        Dioclient();
      }

      final response =
          await dio!.get('https://api-uat-unisphere.bmu.edu.in/health-check');

      print(
          "-------------------------------SERVER STATUS----------------------${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 304) {
        return true;
      } else {
        debugPrint("Health check failed with status: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      debugPrint("Health check failed: ${e.message}");
      return false;
    } catch (e) {
      debugPrint("Unknown error: $e");
      return false;
    }
  }

  // SOLUTION 2: Safe SnackBar method with context validation
  static Future<bool> checkHealthWithSnackbar(BuildContext context) async {
    try {
      if (Dioclient.dio == null) {
        Dioclient();
      }

      final response = await dio!.get('jai bhawani/health-check');
      if (response.statusCode == 200) {
        return true;
      } else {
        _showServerDownSnackBarSafe(context);
        return false;
      }
    } on DioException catch (e) {
      debugPrint("Health check failed: ${e.message}");
      _showServerDownSnackBarSafe(context);
      return false;
    } catch (e) {
      debugPrint("Unknown error: $e");
      _showServerDownSnackBarSafe(context);
      return false;
    }
  }

  // SOLUTION 3: Safe SnackBar helper with context validation
  static void _showServerDownSnackBarSafe(BuildContext context) {
    try {
      // Check if ScaffoldMessenger is available in the context
      final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
      if (scaffoldMessenger != null) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text("Server is currently unavailable."),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Fallback: Just log the error if no ScaffoldMessenger is available
        debugPrint(
          "Server is currently unavailable - No ScaffoldMessenger available to show SnackBar",
        );
      }
    } catch (e) {
      debugPrint("Error showing SnackBar: $e");
    }
  }

  // SOLUTION 4: Alternative method using a callback for error handling
  static Future<bool> checkHealthWithCallback({
    Function(String)? onError,
  }) async {
    try {
      if (Dioclient.dio == null) {
        Dioclient();
      }

      final response = await dio!.get('/health-check');
      if (response.statusCode == 200) {
        return true;
      } else {
        onError?.call("Server is currently unavailable.");
        return false;
      }
    } on DioException catch (e) {
      debugPrint("Health check failed: ${e.message}");
      onError?.call("Server is currently unavailable.");
      return false;
    } catch (e) {
      debugPrint("Unknown error: $e");
      onError?.call("Server is currently unavailable.");
      return false;
    }
  }

  // Keep the original method for backward compatibility (but deprecated)
  @deprecated
  static void showServerDownSnackBar(BuildContext context) {
    _showServerDownSnackBarSafe(context);
  }

  //Added by Mayank to upload files to S3 using a presigned URL
  static Future<bool> putFileToPresignedUrl(String uploadUrl, File file) async {
    try {
      final fileBytes = await file.readAsBytes();
      final contentType = "image/${file.path.split('.').last}";

      final tempDio = Dio(); // No auth header here
      final response = await tempDio.put(
        uploadUrl,
        data: Stream.fromIterable([fileBytes]),
        options: Options(
          headers: {
            'Content-Type': contentType,
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      debugPrint("❌ Failed to upload file to S3: $e");
      return false;
    }
  }
}
