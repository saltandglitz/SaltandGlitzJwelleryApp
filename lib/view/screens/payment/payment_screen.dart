import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandglitz/view/components/common_button.dart';

import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/payment_controller/payment_controller.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedPaymentIndex = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainController = Get.put<MainController>(MainController());
    final paymentController = Get.put<PaymentController>(PaymentController());

    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Text(LocalStrings.appName),
          titleTextStyle: regularLarge.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorResources.buttonColor,
          ),
          leading: IconButton(
            onPressed: () {
              mainController.checkToAssignNetworkConnections();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
            color: ColorResources.buttonColor,
          ),
          backgroundColor: ColorResources.whiteColor,
          elevation: 0,
        ),
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LocalStrings.preferredPayment,
                          style: regularLarge.copyWith(
                            fontWeight: FontWeight.w900,
                            color: ColorResources.buttonColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space10),
                    _buildRadioTile(
                      size * 0.9,
                      LocalStrings.creditCard,
                      LocalStrings.saveAndPayViaCreditCard,
                      0,
                      Icons.credit_card,
                    ),
                    const SizedBox(height: Dimensions.space15),
                    _buildRadioTile(
                      size * 0.9,
                      LocalStrings.debitCard,
                      LocalStrings.saveAndPayViaDebitCard,
                      1,
                      Icons.credit_card,
                    ),
                    const SizedBox(height: Dimensions.space15),
                    _buildRadioTile(
                      size * 0.9,
                      LocalStrings.upi,
                      LocalStrings.paytmGooglePay,
                      2,
                      Icons.account_balance_wallet,
                    ),
                    const SizedBox(height: Dimensions.space15),
                    _buildRadioTile(
                      size * 0.9,
                      LocalStrings.netBanking,
                      LocalStrings.selectFromListOfBanks,
                      3,
                      Icons.account_balance_rounded,
                    ),
                    const SizedBox(height: Dimensions.space15),
                    const SizedBox(height: Dimensions.space25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LocalStrings.giftCard,
                          style: regularLarge.copyWith(
                            fontWeight: FontWeight.w900,
                            color: ColorResources.buttonColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space25),
                    _buildInfoTile(
                      size * 0.9,
                      LocalStrings.haveAGiftCard,
                      LocalStrings.availableAdditionalDiscount,
                      Icons.card_giftcard,
                    ),
                    const SizedBox(height: Dimensions.space25),
                    CommonButton(
                      gradientFirstColor: ColorResources.buttonColor,
                      gradientSecondColor: ColorResources.buttonColor,
                      width: double.infinity,
                      buttonName: paymentController.isCreatingOrder.value ||
                              paymentController.isVerifyingPayment.value
                          ? "Processing..."
                          : LocalStrings.payNow,
                      textStyle: mediumLarge.copyWith(
                        color: ColorResources.whiteColor,
                      ),
                      onTap: selectedPaymentIndex == -1
                          ? null
                          : () async {
                              if (paymentController.isCreatingOrder.value ||
                                  paymentController.isVerifyingPayment.value) {
                                return;
                              }

                              await _handlePayment(paymentController);
                            },
                    ),
                    const SizedBox(height: Dimensions.space20),
                  ],
                ),
              ),
            ),

            // Loading overlay
            if (paymentController.isCreatingOrder.value ||
                paymentController.isVerifyingPayment.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: ColorResources.buttonColor,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Processing Payment...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Future<void> _handlePayment(PaymentController paymentController) async {
    try {
      // Get user info
      final userId = PrefManager.getString('userId');
      final userEmail = PrefManager.getString('userEmail');
      final userPhone = PrefManager.getString('userPhone');
      final userName = PrefManager.getString('userName');

      if (userId == null || userId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please log in to continue payment"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Get cart total (optional - the API can calculate from cart if not provided)
      final cartTotal = await paymentController.getCartTotal();

      // Process payment
      await paymentController.processPayment(
        selectedMethodIndex: selectedPaymentIndex,
        userId: userId,
        userEmail: userEmail,
        userPhone: userPhone,
        userName: userName,
        amount: cartTotal,
      );
    } catch (e) {
      debugPrint('Error in payment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildRadioTile(
    Size size,
    String title,
    String subtitle,
    int index,
    IconData icon,
  ) {
    final paymentController = Get.find<PaymentController>();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xfff6f4f9),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1),
        constraints: const BoxConstraints(minHeight: 50),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          leading: Container(
            width: size.width * 0.14,
            height: size.width * 0.14,
            decoration: BoxDecoration(
              color: ColorResources.buttonColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: ColorResources.buttonColor, size: 25),
          ),
          title: Text(
            title,
            style: mediumLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorResources.buttonColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: mediumSmall.copyWith(
              color: ColorResources.buttonColor,
            ),
          ),
          trailing: Obx(() {
            return Radio<int>(
              value: index,
              groupValue: selectedPaymentIndex,
              activeColor: ColorResources.buttonColor,
              onChanged: paymentController.isCreatingOrder.value ||
                      paymentController.isVerifyingPayment.value
                  ? null
                  : (value) {
                      setState(() {
                        selectedPaymentIndex = value!;
                      });
                    },
            );
          }),
          onTap: () {
            if (!paymentController.isCreatingOrder.value &&
                !paymentController.isVerifyingPayment.value) {
              setState(() {
                selectedPaymentIndex = index;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    Size size,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xfff6f4f9),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1),
        constraints: const BoxConstraints(minHeight: 50),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: ColorResources.buttonColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: ColorResources.buttonColor, size: 18),
          ),
          title: Text(
            title,
            style: mediumLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorResources.buttonColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: mediumSmall.copyWith(
              color: ColorResources.buttonColor,
            ),
          ),
          trailing: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              text: LocalStrings.add,
              style: mediumLarge.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: ColorResources.buttonColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
