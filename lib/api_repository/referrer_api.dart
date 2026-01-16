import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/model/referrer_model.dart';
import 'api_class.dart';

/// Referrer API service for handling referrer-related API calls
class ReferrerApi {
  static const String _baseUrl = 'https://api.saltandglitz.com/v1/referrer';

  /// Submit a request to become a referrer
  /// POST /v1/referrer/request
  static Future<ReferrerSubmitResponse?> submitReferrerRequest({
    required BuildContext context,
    required String userId,
    String? reason,
    bool isLoading = true,
  }) async {
    try {
      final httpUtil = HttpUtil('', isLoading, context);
      final response = await httpUtil.post(
        '$_baseUrl/request',
        data: {
          'userId': userId,
          if (reason != null && reason.isNotEmpty) 'reason': reason,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ReferrerSubmitResponse.fromJson(
            response.data as Map<String, dynamic>);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('ReferrerApi.submitReferrerRequest error: ${e.message}');
      return null;
    }
  }

  /// Get the current referrer status for a user
  /// GET /v1/referrer/status/:userId
  static Future<ReferrerStatusResponse?> getReferrerStatus({
    required BuildContext context,
    required String userId,
    bool isLoading = true,
  }) async {
    try {
      final httpUtil = HttpUtil('', isLoading, context);
      final response = await httpUtil.get(
        '$_baseUrl/status/$userId',
      );

      if (response.statusCode == 200) {
        return ReferrerStatusResponse.fromJson(
            response.data as Map<String, dynamic>);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('ReferrerApi.getReferrerStatus error: ${e.message}');
      return null;
    }
  }

  /// Get referrer statistics (only for approved referrers)
  /// GET /v1/referrer/stats/:userId
  static Future<ReferrerStatsResponse?> getReferrerStats({
    required BuildContext context,
    required String userId,
    bool isLoading = true,
  }) async {
    try {
      final httpUtil = HttpUtil('', isLoading, context);
      final response = await httpUtil.get(
        '$_baseUrl/stats/$userId',
      );

      if (response.statusCode == 200) {
        return ReferrerStatsResponse.fromJson(
            response.data as Map<String, dynamic>);
      }
      return null;
    } on DioException catch (e) {
      debugPrint('ReferrerApi.getReferrerStats error: ${e.message}');
      return null;
    }
  }
}
