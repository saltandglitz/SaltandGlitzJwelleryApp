import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/main_controller.dart';
import 'package:saltandGlitz/view/components/common_button.dart';

import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../components/app_bar_background.dart';
import '../../components/cached_image.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
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
          title: Text("${LocalStrings.appName}"),
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
          actions: [
            CircleAvatar(
              backgroundColor: ColorResources.whatsappColor,
              radius: 20,
              child: Image.asset(
                MyImages.whatsappImage,
                height: size.height * 0.025,
                color: ColorResources.whiteColor,
              ),
            ),
          ],
          backgroundColor: ColorResources.whiteColor,

          elevation: 0, // Remove default shadow
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: Dimensions.space35,
              ),
              Center(
                child: Text(
                  LocalStrings.deliveryDetails,
                  style: boldMediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.conceptTextColor),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.conceptTextColor),
              ),
              const SizedBox(
                height: Dimensions.space40,
              ),
              Center(
                child: Text(
                  LocalStrings.shippingAddress,
                  style: boldMediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.space10,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.conceptTextColor),
              ),
              const SizedBox(
                height: Dimensions.space40,
              ),
              Center(
                child: Text(
                  LocalStrings.billingAddress,
                  style: boldMediumLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.space10,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.conceptTextColor),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.conceptTextColor),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              CommonButton(
                gradientFirstColor: ColorResources.activeCardColor,
                gradientSecondColor: ColorResources.activeCardColor,
                width: double.infinity,
                buttonName: LocalStrings.continuePlaceOrder,
                textStyle: boldMediumLarge.copyWith(
                  color: ColorResources.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
