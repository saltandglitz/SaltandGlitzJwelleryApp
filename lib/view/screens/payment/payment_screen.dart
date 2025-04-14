import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/view/components/common_button.dart';

import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
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

    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title:  Text(LocalStrings.appName),
          titleTextStyle: regularLarge.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorResources.conceptTextColor,
          ),
          leading: IconButton(
            onPressed: () {
              mainController.checkToAssignNetworkConnections();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
            color: ColorResources.conceptTextColor,
          ),
          backgroundColor: ColorResources.whiteColor,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
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
                      color: ColorResources.conceptTextColor,
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
              _buildRadioTile(
                size * 0.9,
                LocalStrings.cashOnDelivery,
                LocalStrings.cod,
                4,
                Icons.currency_rupee,
              ),
              const SizedBox(height: Dimensions.space25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    LocalStrings.giftCard,
                    style: regularLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: ColorResources.conceptTextColor,
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
                // gradientFirstColor: const Color(0xff6d9ebc),
                // gradientSecondColor: const Color(0xff6d9ebc),
                gradientFirstColor: ColorResources.conceptTextColor,
                gradientSecondColor: ColorResources.conceptTextColor,
                width: double.infinity,
                buttonName: LocalStrings.payNow,
                textStyle: mediumLarge.copyWith(
                  color: ColorResources.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile(
    Size size,
    String title,
    String subtitle,
    int index,
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
            width: size.width * 0.14,
            height: size.width * 0.14,
            decoration: BoxDecoration(
              color: ColorResources.conceptTextColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: ColorResources.conceptTextColor, size: 25),
          ),
          title: Text(
            title,
            style: mediumLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorResources.conceptTextColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: mediumSmall.copyWith(
              color: ColorResources.conceptTextColor,
            ),
          ),
          trailing: Radio<int>(
            value: index,
            groupValue: selectedPaymentIndex,
            activeColor: ColorResources.conceptTextColor,
            onChanged: (value) {
              setState(() {
                selectedPaymentIndex = value!;
              });
            },
          ),
          onTap: () {
            setState(() {
              selectedPaymentIndex = index;
            });
          },
        ),
      ),
    );
  }
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: ColorResources.conceptTextColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: ColorResources.conceptTextColor, size: 18),
        ),
        title: Text(
          title,
          style: mediumLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorResources.conceptTextColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: mediumSmall.copyWith(
            color: ColorResources.conceptTextColor,
          ),
        ),
        trailing: RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
            text: LocalStrings.add,
            style: mediumLarge.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: ColorResources.conceptTextColor,
            ),
          ),
        ),
      ),
    ),
  );
}
