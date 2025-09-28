class PaymentConfig {
  // ==================== RAZORPAY CONFIGURATION ====================

  /// Razorpay Key ID - Replace with your actual Razorpay Key ID
  /// Get this from: https://dashboard.razorpay.com/app/keys
  ///
  /// For Testing: Use Test Key ID (starts with 'rzp_test_')
  /// For Production: Use Live Key ID (starts with 'rzp_live_')
  static const String razorpayKeyId = 'rzp_test_RN26TMkYi7dR4G';

  /// Razorpay Key Secret (DO NOT expose this in client-side code)
  /// This should be kept on your backend server only
  /// Used for payment verification on server side

  // ==================== PAYMENT SETTINGS ====================

  /// Company/Business name to display in Razorpay checkout
  static const String companyName = 'Salt & Glitz';

  /// Payment description
  static const String paymentDescription = 'Jewelry Purchase';

  /// Currency code (ISO 4217)
  static const String currency = 'INR';

  /// Theme color for Razorpay checkout (Hex color without #)
  static const String themeColor = '6d9ebc';

  // ==================== ENVIRONMENT CONFIGURATION ====================

  /// Current environment
  static const PaymentEnvironment environment = PaymentEnvironment.test;

  // ==================== PAYMENT METHODS ====================

  /// Available payment methods
  static const List<PaymentMethod> availablePaymentMethods = [
    PaymentMethod.creditCard,
    PaymentMethod.debitCard,
    PaymentMethod.upi,
    PaymentMethod.netBanking,
  ];

  // ==================== TIMEOUT SETTINGS ====================

  /// Payment timeout in seconds
  static const int paymentTimeout = 300; // 5 minutes

  /// Order creation timeout in seconds
  static const int orderCreationTimeout = 30;

  /// Payment verification timeout in seconds
  static const int verificationTimeout = 30;

  // ==================== ERROR MESSAGES ====================

  static const String paymentFailedMessage =
      'Payment failed. Please try again.';
  static const String paymentCancelledMessage = 'Payment was cancelled.';
  static const String networkErrorMessage =
      'Network error. Please check your connection.';
  static const String invalidAmountMessage = 'Invalid payment amount.';
  static const String userNotLoggedInMessage =
      'Please log in to continue payment.';

  // ==================== SUCCESS MESSAGES ====================

  static const String paymentSuccessMessage = 'Payment completed successfully!';

  // ==================== HELPER METHODS ====================

  /// Get Razorpay options for checkout
  static Map<String, dynamic> getRazorpayOptions({
    required String orderId,
    required int amountInPaisa,
    required String userEmail,
    required String userPhone,
    required String userName,
  }) {
    return {
      'key': razorpayKeyId,
      'amount': amountInPaisa,
      'name': companyName,
      'description': paymentDescription,
      'order_id': orderId,
      'currency': currency,
      'prefill': {
        'contact': userPhone,
        'email': userEmail,
        'name': userName,
      },
      'theme': {'color': '#$themeColor'},
      'modal': {'confirm_close': true},
      'retry': {'enabled': true, 'max_count': 3}
    };
  }

  /// Convert rupees to paisa (Razorpay uses paisa)
  static int convertToPaisa(double amountInRupees) {
    return (amountInRupees * 100).round();
  }

  /// Convert paisa to rupees
  static double convertToRupees(int amountInPaisa) {
    return amountInPaisa / 100.0;
  }

  /// Check if current environment is production
  static bool isProduction() {
    return environment == PaymentEnvironment.production;
  }

  /// Get appropriate Razorpay key based on environment
  static String getRazorpayKey() {
    if (isProduction()) {
      return razorpayKeyId; // Should be live key in production
    } else {
      return razorpayKeyId; // Should be test key in development
    }
  }
}

// ==================== ENUMS ====================

enum PaymentEnvironment {
  test,
  production,
}

enum PaymentMethod {
  creditCard,
  debitCard,
  upi,
  netBanking,
  cod,
}

enum PaymentStatus {
  pending,
  processing,
  success,
  failed,
  cancelled,
}

// ==================== EXTENSIONS ====================

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.debitCard:
        return 'Debit Card';
      case PaymentMethod.upi:
        return 'UPI';
      case PaymentMethod.netBanking:
        return 'Net Banking';
      case PaymentMethod.cod:
        return 'Cash on Delivery';
    }
  }

  String get description {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Save & Pay via Credit Card';
      case PaymentMethod.debitCard:
        return 'Save & Pay via Debit Card';
      case PaymentMethod.upi:
        return 'Paytm, PhonePe, Google Pay, & more';
      case PaymentMethod.netBanking:
        return 'Select from list of banks';
      case PaymentMethod.cod:
        return 'Pay when you receive';
    }
  }

  bool get isOnlinePayment {
    return this != PaymentMethod.cod;
  }
}

// ==================== SETUP INSTRUCTIONS ====================

/// SETUP INSTRUCTIONS:
///
/// 1. Create Razorpay Account:
///    - Go to https://razorpay.com/ and sign up
///    - Complete KYC and business verification
///
/// 2. Get API Keys:
///    - Go to https://dashboard.razorpay.com/app/keys
///    - Copy your Key ID and Key Secret
///    - For testing, use Test keys (rzp_test_...)
///    - For production, use Live keys (rzp_live_...)
///
/// 3. Update Configuration:
///    - Replace 'rzp_test_your_key_here' with your actual Razorpay Key ID
///    - Update company name, theme color, etc. as needed
///
/// 4. Backend Setup:
///    - Store Key Secret securely on your backend
///    - Never expose Key Secret in client-side code
///    - Use Key Secret for payment verification APIs
///
/// 5. Testing:
///    - Use Razorpay test cards for testing
///    - Test card: 4111 1111 1111 1111, CVV: 123, Expiry: Any future date
///
/// 6. Production Deployment:
///    - Change environment to PaymentEnvironment.production
///    - Use Live keys
///    - Test thoroughly before going live
