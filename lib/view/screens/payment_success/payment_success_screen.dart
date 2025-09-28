import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../core/route/route.dart';
import '../../components/common_button.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  String? orderId;
  String? paymentId;
  double? amount;
  String? paymentMethod;

  @override
  void initState() {
    super.initState();

    // Get payment details from arguments
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      orderId = args['orderId'];
      paymentId = args['paymentId'];
      amount = args['amount'];
      paymentMethod = args['paymentMethod'];
    }

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        _navigateToHome();
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorResources.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Success Icon with Animation
                      AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 80,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: Dimensions.space30),

                      // Success Message
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Column(
                              children: [
                                Text(
                                  "Payment Successful!",
                                  style: regularLarge.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: Dimensions.space10),
                                Text(
                                  "Thank you for your purchase",
                                  style: regularDefault.copyWith(
                                    color: ColorResources.buttonColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: Dimensions.space30),

                      // Payment Details Card
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment Details",
                                      style: mediumLarge.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ColorResources.buttonColor,
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space15),

                                    // Order ID
                                    if (orderId != null)
                                      _buildDetailRow(
                                        "Order ID",
                                        orderId!.length > 20
                                            ? '${orderId!.substring(0, 20)}...'
                                            : orderId!,
                                      ),

                                    // Payment ID
                                    if (paymentId != null)
                                      _buildDetailRow(
                                        "Payment ID",
                                        paymentId!.length > 20
                                            ? '${paymentId!.substring(0, 20)}...'
                                            : paymentId!,
                                      ),

                                    // Amount
                                    if (amount != null)
                                      _buildDetailRow(
                                        "Amount Paid",
                                        "₹${amount!.toStringAsFixed(2)}",
                                        isAmount: true,
                                      ),

                                    // Payment Method
                                    if (paymentMethod != null)
                                      _buildDetailRow(
                                        "Payment Method",
                                        paymentMethod!,
                                      ),

                                    // Transaction Date
                                    _buildDetailRow(
                                      "Date & Time",
                                      _formatDateTime(DateTime.now()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: Dimensions.space20),

                      // Order tracking info
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    ColorResources.buttonColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: ColorResources.buttonColor
                                      .withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: ColorResources.buttonColor,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "You will receive an order confirmation email shortly. Track your order in 'My Orders' section.",
                                      style: regularSmall.copyWith(
                                        color: ColorResources.buttonColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        children: [
                          // Continue Shopping Button
                          CommonButton(
                            gradientFirstColor: ColorResources.buttonColor,
                            gradientSecondColor: ColorResources.buttonColor,
                            width: double.infinity,
                            buttonName: "Continue Shopping",
                            textStyle: mediumLarge.copyWith(
                              color: ColorResources.whiteColor,
                            ),
                            onTap: _navigateToHome,
                          ),

                          const SizedBox(height: Dimensions.space15),

                          // Track Order Button
                          CommonButton(
                            gradientFirstColor: Colors.transparent,
                            gradientSecondColor: Colors.transparent,
                            borderColor: ColorResources.buttonColor,
                            width: double.infinity,
                            buttonName: "Track Order",
                            textStyle: mediumLarge.copyWith(
                              color: ColorResources.buttonColor,
                            ),
                            onTap: _trackOrder,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: regularDefault.copyWith(
              color: ColorResources.buttonColor.withOpacity(0.8),
            ),
          ),
          Text(
            value,
            style: mediumDefault.copyWith(
              color: isAmount ? Colors.green : ColorResources.buttonColor,
              fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  void _navigateToHome() {
    Get.offAllNamed(RouteHelper.bottomBarScreen);
  }

  void _trackOrder() {
    // Navigate to orders screen or show order tracking
    // You can implement this based on your app's navigation structure
    Get.offAllNamed(RouteHelper.bottomBarScreen);
    // Or navigate to specific orders screen:
    // Get.toNamed(RouteHelper.ordersScreen);
  }
}
