import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:dio/dio.dart' as dio;
import '../../../api_repository/dio_client.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../view/components/common_message_show.dart';
import '../../../core/route/route.dart';
import '../../../core/config/payment_config.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;

  // Observable variables
  RxBool isCreatingOrder = false.obs;
  RxBool isVerifyingPayment = false.obs;
  RxString selectedPaymentMethod = ''.obs;

  // Payment data
  String? orderId;
  String? paymentId;
  String? signature;
  double? paymentAmount;

  @override
  void onInit() {
    super.onInit();
    _initializeRazorpay();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  /// Initialize Razorpay
  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// Set selected payment method
  void setSelectedPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  /// Start payment process
  Future<void> startPayment({
    required String userId,
    double? amount,
    required String userEmail,
    required String userPhone,
    required String userName,
  }) async {
    try {
      isCreatingOrder.value = true;

      // Step 1: Create order from backend
      final orderData =
          await _createPaymentOrder(userId: userId, amount: amount);

      if (orderData != null) {
        orderId = orderData['id'];
        paymentAmount = (orderData['amount'] / 100); // Convert paisa to rupees

        // Step 2: Open Razorpay checkout
        var options = PaymentConfig.getRazorpayOptions(
          orderId: orderId!,
          amountInPaisa: orderData['amount'],
          userEmail: userEmail,
          userPhone: userPhone,
          userName: userName,
        );

        // Debug logging
        debugPrint('Razorpay options: $options');

        // Ensure all values are properly serializable
        final cleanOptions = _sanitizeRazorpayOptions(options);
        debugPrint('Sanitized Razorpay options: $cleanOptions');

        _razorpay.open(cleanOptions);
      }
    } catch (e) {
      isCreatingOrder.value = false;
      showToast(
          message: PaymentConfig.networkErrorMessage, context: Get.context!);
      debugPrint('Error starting payment: $e');
    }
  }

  /// Create payment order API call using DioClient
  Future<Map<String, dynamic>?> _createPaymentOrder({
    required String userId,
    double? amount,
  }) async {
    try {
      Map<String, dynamic> params = {
        "userId": userId,
      };

      if (amount != null) {
        params["amount"] = amount;
      }

      debugPrint('Creating payment order with params: $params');

      dio.Response response = await Dioclient.post(
        '/v1/razorpay/pay-order',
        data: params,
      );

      debugPrint('Payment order response: ${response.data}');

      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } catch (e) {
      debugPrint('Error creating payment order: $e');
      showToast(
          message: "${PaymentConfig.networkErrorMessage}: ${e.toString()}",
          context: Get.context!);
    } finally {
      isCreatingOrder.value = false;
    }
    return null;
  }

  /// Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    signature = response.signature;

    debugPrint('Payment Success: ${response.paymentId}');

    // Verify payment with backend
    _verifyPayment(
      orderId: response.orderId ?? orderId!,
      paymentId: response.paymentId!,
      signature: response.signature!,
    );
  }

  /// Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Error: ${response.code} - ${response.message}');
    showToast(
      message: "${PaymentConfig.paymentFailedMessage}: ${response.message}",
      context: Get.context!,
    );

    // Navigate back to payment screen or show retry option
    _handlePaymentFailure(response);
  }

  /// Handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
    showToast(
      message: "External Wallet Selected: ${response.walletName}",
      context: Get.context!,
    );
  }

  /// Verify payment API call using DioClient
  Future<void> _verifyPayment({
    required String orderId,
    required String paymentId,
    required String signature,
  }) async {
    try {
      isVerifyingPayment.value = true;

      Map<String, dynamic> params = {
        "razorpay_order_id": orderId,
        "razorpay_payment_id": paymentId,
        "razorpay_signature": signature,
      };

      debugPrint('Verifying payment with params: $params');

      dio.Response response = await Dioclient.post(
        '/v1/razorpay/verify',
        data: params,
      );

      debugPrint('Payment verification response: ${response.data}');

      if (response.statusCode == 200) {
        debugPrint('Payment verified successfully');
        showToast(
          message: PaymentConfig.paymentSuccessMessage,
          context: Get.context!,
        );

        // Navigate to success screen
        _handlePaymentSuccessComplete();
      }
    } catch (e) {
      debugPrint('Error verifying payment: $e');
      showToast(
        message: "${PaymentConfig.paymentFailedMessage}: ${e.toString()}",
        context: Get.context!,
      );
    } finally {
      isVerifyingPayment.value = false;
    }
  }

  /// Handle successful payment completion
  void _handlePaymentSuccessComplete() {
    // Clear cart, navigate to success screen, etc.
    Get.offAllNamed(RouteHelper.bottomBarScreen); // Navigate to home

    // You can also navigate to an order success screen
    // Get.toNamed(RouteHelper.orderSuccessScreen);

    // Clear payment data
    _clearPaymentData();
  }

  /// Handle payment failure
  void _handlePaymentFailure(PaymentFailureResponse response) {
    // You can navigate to a failure screen or show retry options
    // For now, just stay on the payment screen

    // Clear payment data
    _clearPaymentData();
  }

  /// Clear payment data
  void _clearPaymentData() {
    orderId = null;
    paymentId = null;
    signature = null;
    paymentAmount = null;
    selectedPaymentMethod.value = '';
  }

  /// Get payment method display name
  String getPaymentMethodName(int index) {
    switch (index) {
      case 0:
        return 'Credit Card';
      case 1:
        return 'Debit Card';
      case 2:
        return 'UPI';
      case 3:
        return 'Net Banking';
      default:
        return 'Unknown';
    }
  }

  /// Get user info for payment
  Map<String, String> _getUserInfo() {
    // You can fetch user info from PrefManager or user controller
    return {
      'email': PrefManager.getString('userEmail') ?? '',
      'phone': PrefManager.getString('userPhone') ?? '',
      'name': PrefManager.getString('userName') ?? 'User',
      'userId': PrefManager.getString('userId') ?? '',
    };
  }

  /// Process payment based on selected method
  Future<void> processPayment({
    required int selectedMethodIndex,
    String? userId,
    String? userEmail,
    String? userPhone,
    String? userName,
    double? amount,
  }) async {
    final methodName = getPaymentMethodName(selectedMethodIndex);
    setSelectedPaymentMethod(methodName);

    // Get user info
    final userInfo = _getUserInfo();
    final finalUserId = userId ?? userInfo['userId']!;
    final finalUserEmail = userEmail ?? userInfo['email']!;
    final finalUserPhone = userPhone ?? userInfo['phone']!;
    final finalUserName = userName ?? userInfo['name']!;

    if (finalUserId.isEmpty) {
      showToast(
        message: PaymentConfig.userNotLoggedInMessage,
        context: Get.context!,
      );
      return;
    }

    // All payment methods are now online payments
    await startPayment(
      userId: finalUserId,
      amount: amount,
      userEmail: finalUserEmail,
      userPhone: finalUserPhone,
      userName: finalUserName,
    );
  }

  /// Sanitize Razorpay options to ensure all values are serializable
  Map<String, dynamic> _sanitizeRazorpayOptions(Map<String, dynamic> options) {
    final sanitized = <String, dynamic>{};

    options.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        // Recursively sanitize nested maps
        sanitized[key] = _sanitizeRazorpayOptions(value);
      } else if (value is Function || value == null) {
        // Skip functions and null values
        debugPrint('Skipping non-serializable value for key: $key');
      } else {
        // Keep primitive values
        sanitized[key] = value;
      }
    });

    return sanitized;
  }

  /// Get cart total amount (you can implement this based on your cart logic)
  Future<double?> getCartTotal() async {
    try {
      final userId = PrefManager.getString('userId');
      if (userId == null || userId.isEmpty) return null;

      dio.Response response = await Dioclient.get('/cart/getCart/$userId');

      if (response.statusCode == 200) {
        // Extract total amount from cart response
        // This depends on your cart API response structure
        final cartData = response.data;
        debugPrint('Cart API Response: $cartData');

        // Check different possible fields for total amount
        if (cartData['cart'] != null && cartData['cart']['cartTotal'] != null) {
          final total = cartData['cart']['cartTotal'].toDouble();
          debugPrint('Using cartTotal: $total');
          return total;
        } else if (cartData['totalPrice'] != null) {
          final total = cartData['totalPrice'].toDouble();
          debugPrint('Using totalPrice: $total');
          return total;
        } else if (cartData['totalAmount'] != null) {
          final total = cartData['totalAmount'].toDouble();
          debugPrint('Using totalAmount: $total');
          return total;
        }

        debugPrint('No total amount found in cart response');
        return null;
      }
    } catch (e) {
      debugPrint('Error getting cart total: $e');
    }
    return null;
  }

  /// Test Razorpay options format for debugging
  void testRazorpayOptionsFormat() {
    try {
      final testOptions = PaymentConfig.getRazorpayOptions(
        orderId: 'test_order_123',
        amountInPaisa: 100000,
        userEmail: 'test@example.com',
        userPhone: '1234567890',
        userName: 'Test User',
      );

      debugPrint('Test Razorpay options structure: $testOptions');

      final sanitized = _sanitizeRazorpayOptions(testOptions);
      debugPrint('Sanitized options: $sanitized');
    } catch (e) {
      debugPrint('Error in test options: $e');
    }
  }
}
