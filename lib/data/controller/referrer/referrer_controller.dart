import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api_repository/referrer_api.dart';
import '../../../local_storage/pref_manager.dart';
import '../../model/referrer_model.dart';

/// GetX Controller for managing referrer/special user state
class ReferrerController extends GetxController {
  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isSubmitting = false.obs;

  // Referrer status
  final RxBool isReferrer = false.obs;
  final RxString referrerStatus = 'not_applied'.obs; // not_applied, pending, approved, rejected
  final RxString couponCode = ''.obs;

  // Referrer request details
  final Rx<ReferrerRequest?> latestRequest = Rx<ReferrerRequest?>(null);

  // Referrer stats (for approved referrers)
  final Rx<ReferrerStats?> stats = Rx<ReferrerStats?>(null);

  // Error message
  final RxString errorMessage = ''.obs;

  // Text controller for reason input
  final TextEditingController reasonController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchReferrerStatus();
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }

  /// Get the current user ID from preferences
  String? get userId => PrefManager.getString('userId');

  /// Fetch the current referrer status for the logged-in user
  Future<void> fetchReferrerStatus({bool showLoading = true}) async {
    if (userId == null || userId!.isEmpty) {
      referrerStatus.value = 'not_applied';
      return;
    }

    try {
      if (showLoading) isLoading.value = true;
      errorMessage.value = '';

      final context = Get.context;
      if (context == null) return;

      final response = await ReferrerApi.getReferrerStatus(
        context: context,
        userId: userId!,
        isLoading: false,
      );

      if (response != null) {
        isReferrer.value = response.isReferrer ?? false;
        couponCode.value = response.couponCode ?? '';
        latestRequest.value = response.latestRequest;

        // Determine status
        if (response.isReferrer == true) {
          referrerStatus.value = 'approved';
          // Fetch stats for approved referrers
          await fetchReferrerStats(showLoading: false);
        } else if (response.latestRequest != null) {
          referrerStatus.value = response.latestRequest!.status ?? 'pending';
        } else {
          referrerStatus.value = 'not_applied';
        }
      } else {
        referrerStatus.value = 'not_applied';
      }
    } catch (e) {
      debugPrint('ReferrerController.fetchReferrerStatus error: $e');
      errorMessage.value = 'Failed to fetch status. Please try again.';
    } finally {
      if (showLoading) isLoading.value = false;
      update();
    }
  }

  /// Submit a request to become a referrer
  Future<bool> submitReferrerRequest() async {
    if (userId == null || userId!.isEmpty) {
      errorMessage.value = 'Please login to continue';
      return false;
    }

    try {
      isSubmitting.value = true;
      errorMessage.value = '';

      final context = Get.context;
      if (context == null) return false;

      final response = await ReferrerApi.submitReferrerRequest(
        context: context,
        userId: userId!,
        reason: reasonController.text.trim(),
        isLoading: true,
      );

      if (response != null && response.request != null) {
        latestRequest.value = response.request;
        referrerStatus.value = 'pending';
        reasonController.clear();
        update();
        return true;
      } else {
        errorMessage.value = 'Failed to submit request. Please try again.';
        return false;
      }
    } catch (e) {
      debugPrint('ReferrerController.submitReferrerRequest error: $e');
      errorMessage.value = 'An error occurred. Please try again.';
      return false;
    } finally {
      isSubmitting.value = false;
      update();
    }
  }

  /// Fetch referrer stats (for approved referrers only)
  Future<void> fetchReferrerStats({bool showLoading = true}) async {
    if (userId == null || userId!.isEmpty || !isReferrer.value) {
      return;
    }

    try {
      if (showLoading) isLoading.value = true;

      final context = Get.context;
      if (context == null) return;

      final response = await ReferrerApi.getReferrerStats(
        context: context,
        userId: userId!,
        isLoading: false,
      );

      if (response != null && response.stats != null) {
        stats.value = response.stats;
        if (response.stats!.couponCode != null) {
          couponCode.value = response.stats!.couponCode!;
        }
      }
    } catch (e) {
      debugPrint('ReferrerController.fetchReferrerStats error: $e');
    } finally {
      if (showLoading) isLoading.value = false;
      update();
    }
  }

  /// Refresh all data
  Future<void> refreshData() async {
    await fetchReferrerStatus(showLoading: true);
  }

  /// Get status display text
  String get statusDisplayText {
    switch (referrerStatus.value) {
      case 'pending':
        return 'Pending Review';
      case 'approved':
        return 'Special User';
      case 'rejected':
        return 'Request Declined';
      default:
        return 'Become Special User';
    }
  }

  /// Get status color
  Color get statusColor {
    switch (referrerStatus.value) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
