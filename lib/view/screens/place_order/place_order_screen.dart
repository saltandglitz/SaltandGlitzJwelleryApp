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
          title: const Text(LocalStrings.appName),
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
        physics: const BouncingScrollPhysics(),
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
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffe2ecee),
                  border: Border.all(
                    color: const Color(0xffc3dbda),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          LocalStrings.homeDelivery,
                          style: mediumDefault.copyWith(
                              fontWeight: FontWeight.w900,
                              color: ColorResources.conceptTextColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.space30,
                    ),
                    Text(
                      LocalStrings.earliestDelivery,
                      style: mediumSmall.copyWith(
                        color: ColorResources.conceptTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space25,
                    ),
                    CommonButton(
                      buttonName: LocalStrings.changeYourDeliveryDate,
                      textStyle: mediumSmall.copyWith(
                        color: ColorResources.blackColor,
                      ),
                      height: size.height * 0.046,
                      width: size.width * 0.6,
                      gradientFirstColor: ColorResources.whiteColor,
                      gradientSecondColor: ColorResources.whiteColor,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xfff6f4f9),
                  border: Border.all(
                    color: const Color(0xffe8e4ef),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalStrings.inStorePickUp,
                      style: mediumDefault.copyWith(
                        fontWeight: FontWeight.w900,
                        color: ColorResources.conceptTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space20,
                    ),
                    Text(
                      LocalStrings.buyNowPickUp,
                      style: mediumSmall.copyWith(
                        color: ColorResources.conceptTextColor,
                      ),
                    ),
                  ],
                ),
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
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xfff0f4f7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Text(
                      LocalStrings.addANewAddress,
                      style: mediumDefault.copyWith(
                        color: ColorResources.conceptTextColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Transform.translate(
                      offset: const Offset(270, 0),
                      child: Container(
                        height: size.height * 0.1,
                        width: size.width * 0.099,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  ColorResources.borderColor.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: ColorResources.whiteColor,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: ColorResources.conceptTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
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
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xfff6f4f9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  LocalStrings.sameAsShippingAddress,
                  style: mediumDefault.copyWith(
                    color: ColorResources.conceptTextColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xfff6f4f9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  LocalStrings.useADifferentBillingAddress,
                  style: mediumDefault.copyWith(
                    color: ColorResources.conceptTextColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              CommonButton(
                gradientFirstColor: const Color(0xff67bed1),
                gradientSecondColor: const Color(0xff67bed1),
                width: double.infinity,
                buttonName: LocalStrings.continuePlaceOrder,
                textStyle: boldMediumLarge.copyWith(
                  color: ColorResources.whiteColor,
                ),
              ),
              const SizedBox(
                height: Dimensions.space70,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  LocalStrings.orderSummary,
                  style: mediumExtraLarge.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.space30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: size.width * 0.32,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: ColorResources.conceptTextColor),
                        color: ColorResources.whiteColor,
                        image: const DecorationImage(
                          image: AssetImage(MyImages.ringOneImage),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocalStrings.earring,
                        style: mediumDefault.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        LocalStrings.sku,
                        style: mediumDefault.copyWith(),
                      ),
                      Text(
                        "${LocalStrings.quantity}: 1",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        LocalStrings.price,
                        style: mediumLarge.copyWith(),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: Dimensions.space30,
              ),
              const Divider(),
              const SizedBox(
                height: Dimensions.space20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalStrings.subTotal2,
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ 5,35,448",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalStrings.couponDiscount,
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "-₹0",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalStrings.shippingCharges,
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "FREE",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorResources.offerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.space20,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocalStrings.totalCost,
                    style: mediumLarge.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "₹ 5,35,448",
                    style: mediumLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.space20,
              ),
              Center(
                child: Text(
                  LocalStrings.needHelp2,
                  style: mediumLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorResources.offerColor),
                ),
              ),
              const SizedBox(
                height: Dimensions.space15,
              ),
              Center(
                child: Text(
                  LocalStrings.weAreAvailable,
                  textAlign: TextAlign.center,
                  style: mediumDefault.copyWith(),
                ),
              ),
              const SizedBox(
                height: Dimensions.space35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorResources.conceptTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.whatsappImage,
                        height: size.height * 0.025,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorResources.conceptTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.emailImage,
                        height: size.height * 0.025,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: ColorResources.conceptTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.phoneCallImage,
                        height: size.height * 0.025,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.space25,
              ),
              const Divider(),
              const SizedBox(
                height: Dimensions.space60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocalStrings.contactUs2,
                    style: mediumLarge.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    LocalStrings.contactNumber,
                    style: mediumLarge.copyWith(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
