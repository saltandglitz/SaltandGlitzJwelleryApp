import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandglitz/data/controller/place_order_controller/place_order_controller.dart';
import 'package:saltandglitz/main_controller.dart';
import 'package:saltandglitz/view/components/cached_image.dart';
import 'package:saltandglitz/view/components/common_button.dart';
import 'package:saltandglitz/view/components/common_textfield.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../local_storage/pref_manager.dart';
import '../../components/app_bar_background.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final placeOrderController =
      Get.put<PlaceOrderController>(PlaceOrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placeOrderController.getCartApiMethod();
    if (Get.arguments != null) {
      placeOrderController.cartId = Get.arguments;
    }
    if (PrefManager.getString('isLogin') == "yes") {
      placeOrderController.firstNameNewAddress.text =
          PrefManager.getString('firstName') ?? '';
      placeOrderController.lastNameNewAddress.text =
          PrefManager.getString('lastName') ?? '';
      placeOrderController.mobileNumberNewAddress.text =
          PrefManager.getString('phoneNumber') ?? '';
    }
    placeOrderController.getAddressApiMethod();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedAddressType;
    final size = MediaQuery.of(context).size;
    final mainController = Get.put<MainController>(MainController());

    return GetBuilder(
      init: PlaceOrderController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorResources.scaffoldBackgroundColor,
          appBar: AppBarBackground(
            child: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Text(LocalStrings.appName.toUpperCase()),
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
              actions: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorResources.whatsappColor,
                      radius: 20,
                      child: Image.asset(
                        MyImages.whatsappImage,
                        height: size.height * 0.025,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.space12),
                  ],
                ),
              ],
              backgroundColor: ColorResources.whiteColor,
              elevation: 0,
            ),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.space10),
                  /*  Center(
                    child: Text(
                      LocalStrings.deliveryDetails,
                      style: boldMediumLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space15),
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
                                color: ColorResources.buttonColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space30),
                        Text(
                          LocalStrings.earliestDelivery,
                          style: mediumSmall.copyWith(
                            color: ColorResources.buttonColor,
                          ),
                        ),
                        const SizedBox(height: Dimensions.space25),
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
                  const SizedBox(height: Dimensions.space15),
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
                            color: ColorResources.buttonColor,
                          ),
                        ),
                        const SizedBox(height: Dimensions.space20),
                        Text(
                          LocalStrings.buyNowPickUp,
                          style: mediumSmall.copyWith(
                            color: ColorResources.buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space40),*/

                  placeOrderController.getAddress.isNotEmpty
                      ? ListView.builder(
                          itemCount: placeOrderController.getAddress.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: const Color(0xfff6f4f9),
                                child: Theme(
                                  data: ThemeData(
                                      splashColor: Colors.transparent),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        // Radio Button
                                        Obx(
                                          () {
                                            return Radio<int>(
                                              value: index,
                                              groupValue: placeOrderController
                                                  .selectedIndex.value,
                                              activeColor:
                                                  ColorResources.buttonColor,
                                              onChanged: (value) {
                                                placeOrderController
                                                    .selectAddress(value!);
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                            width: Dimensions.space5),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: LocalStrings.street,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: placeOrderController
                                                          .getAddress[index]
                                                          .street,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorResources
                                                            .buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: LocalStrings
                                                          .cityWithDots,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: placeOrderController
                                                          .getAddress[index]
                                                          .city,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorResources
                                                            .buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: LocalStrings
                                                          .stateWithDots,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: placeOrderController
                                                          .getAddress[index]
                                                          .state,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorResources
                                                            .buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: LocalStrings
                                                          .postalCode,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: placeOrderController
                                                          .getAddress[index]
                                                          .postalCode,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorResources
                                                            .buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: LocalStrings
                                                          .countryWithDots,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: placeOrderController
                                                          .getAddress[index]
                                                          .country,
                                                      style: boldMediumLarge
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorResources
                                                            .buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                  const SizedBox(height: Dimensions.space10),
                  Center(
                    child: Text(
                      LocalStrings.shippingAddress,
                      style: boldMediumLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  GestureDetector(
                    onTap: () {
                      mainController.checkToAssignNetworkConnections();

                      /// Add address dialog box
                      // Clear all fields before opening the dialog
                      controller.clearAllNewAddressField();
                      addAddressDialogBox(
                          selectedAddressType: selectedAddressType,
                          controller: controller);
                    },
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.07,
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
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocalStrings.addANewAddress,
                            style: boldLarge.copyWith(
                              color: ColorResources.buttonColor,
                            ),
                          ),
                          Container(
                            height: size.height * 0.1,
                            width: size.width * 0.099,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.borderColor
                                      .withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              shape: BoxShape.circle,
                              color: ColorResources.addressColor,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: ColorResources.buttonColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space30),
                  Center(
                    child: Text(
                      LocalStrings.billingAddress,
                      style: boldMediumLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  // Container(
                  //   width: double.infinity,
                  //   height: size.height * 0.10,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: const Color(0xfff6f4f9),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.shade300,
                  //         spreadRadius: 3,
                  //         blurRadius: 6,
                  //         offset: const Offset(0, 4),
                  //       ),
                  //     ],
                  //   ),
                  //   alignment: Alignment.centerLeft,
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         LocalStrings.sameAsShippingAddress,
                  //         style: mediumDefault.copyWith(
                  //           color: ColorResources.buttonColor,
                  //           fontWeight: FontWeight.w900,
                  //         ),
                  //       ),
                  //       Radio<bool>(
                  //         value: true,
                  //         groupValue: selectedValue
                  //             ? true
                  //             : null, // Deselect on second click
                  //         onChanged: (value) {
                  //           toggleSelection(); // Toggle on click
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: Dimensions.space15),
                  // Container(
                  //   width: double.infinity,
                  //   height: size.height * 0.10,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: const Color(0xfff6f4f9),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.shade300,
                  //         spreadRadius: 3,
                  //         blurRadius: 6,
                  //         offset: const Offset(0, 4),
                  //       ),
                  //     ],
                  //   ),
                  //   alignment: Alignment.centerLeft,
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         LocalStrings.useADifferentBillingAddress,
                  //         style: mediumDefault.copyWith(
                  //           color: ColorResources.buttonColor,
                  //           fontWeight: FontWeight.w900,
                  //         ),
                  //       ),
                  //       Radio<bool>(
                  //         value: true,
                  //         groupValue: selectedValue
                  //             ? true
                  //             : null, // Deselect on second click
                  //         onChanged: (value) {
                  //           toggleSelection();
                  //           // Toggle on click
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  GetBuilder(
                    init: PlaceOrderController(),
                    builder: (controller) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildRadioTile(
                            size * 0.9,
                            LocalStrings.sameAsShippingAddress,
                            controller.isSameAsShipping,
                            () => controller.selectAddressOption(true),
                          ),
                          const SizedBox(height: Dimensions.space15),
                          _buildRadioTile(
                            size * 0.9,
                            LocalStrings.useADifferentBillingAddress,
                            !controller.isSameAsShipping,
                            () => controller.selectAddressOption(false),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: Dimensions.space15),
                  GetBuilder(
                    init: PlaceOrderController(),
                    builder: (controller) {
                      return controller.isSameAsShipping
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      LocalStrings.addANewAddress,
                                      style: boldMediumLarge,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CommonTextField(
                                            controller: controller
                                                .firstNameDifferentAddress,
                                            hintText: LocalStrings.firstName,
                                            hintTexStyle: mediumDefault,
                                            fillColor:
                                                ColorResources.whiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        Expanded(
                                          child: CommonTextField(
                                            controller: controller
                                                .lastNameDifferentAddress,
                                            hintText: LocalStrings.lastName,
                                            hintTexStyle: mediumDefault,
                                            fillColor:
                                                ColorResources.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    CommonTextField(
                                      controller:
                                          controller.streetDifferentAddress,
                                      hintText: LocalStrings.streetHouseNumber,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    CommonTextField(
                                      controller: controller
                                          .additionalInformationDifferentAddress,
                                      hintText:
                                          LocalStrings.additionalInformation,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CommonTextField(
                                            controller: controller
                                                .pinCodeDifferentAddress,
                                            hintText: LocalStrings.pinCode,
                                            hintTexStyle: mediumDefault,
                                            fillColor:
                                                ColorResources.whiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        Expanded(
                                          child: CommonTextField(
                                            controller:
                                                controller.cityDifferentAddress,
                                            hintText: LocalStrings.city,
                                            hintTexStyle: mediumDefault,
                                            fillColor:
                                                ColorResources.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CommonTextField(
                                            controller: controller
                                                .stateDifferentAddress,
                                            hintText: LocalStrings.state,
                                            hintTexStyle: mediumDefault,
                                            fillColor:
                                                ColorResources.whiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        Expanded(
                                          child: CommonTextField(
                                            controller: controller
                                                .countryDifferentAddress,
                                            hintText: LocalStrings.country,
                                            hintTexStyle: mediumDefault,
                                            fillColor:
                                                ColorResources.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    CommonTextField(
                                      controller: controller
                                          .mobileNumberDifferentAddress,
                                      hintText: LocalStrings.mobileNumber,
                                      hintTexStyle: mediumDefault,
                                      fillColor: ColorResources.whiteColor,
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        fillColor: ColorResources.whiteColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          borderSide: BorderSide(
                                            color: ColorResources.borderColor,
                                            width: 1,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      hint: Text(
                                        LocalStrings.selectAddressType,
                                        style: const TextStyle(
                                          color: ColorResources.borderColor,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: ColorResources.blackColor,
                                      ),
                                      value: selectedAddressType,
                                      items: ['Home', 'Work', 'Other'].map(
                                        (String type) {
                                          return DropdownMenuItem<String>(
                                            value: type,
                                            child: Text(
                                              type,
                                              style: const TextStyle(
                                                color:
                                                    ColorResources.blackColor,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        selectedAddressType = value;
                                      },
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    /* Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                controller
                                                    .clearAllDifferentAddressField();
                                                Get.back();
                                              },
                                              child: Text(LocalStrings.cancel),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Get.back();
                                              },
                                              child: Text(LocalStrings.save),
                                            ),
                                          ],
                                        ),*/
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                  const SizedBox(height: Dimensions.space20),
                  CommonButton(
                    gradientFirstColor: ColorResources.buttonColor,
                    gradientSecondColor: ColorResources.buttonColor,
                    width: double.infinity,
                    onTap: placeOrderController.isCreateOrder.value == true
                        ? () {}
                        : () {
                            /// Create order method
                            controller.createOrderApiMethod(
                              cartId: controller.cartId,
                              streetNewAddress:
                                  controller.streetNewAddress.text.trim(),
                              cityNewAddress:
                                  controller.cityNewAddress.text.trim(),
                              stateNewAddress:
                                  controller.stateNewAddress.text.trim(),
                              postalCodeNewAddress:
                                  controller.pinCodeNewAddress.text.trim(),
                              countryNewAddress:
                                  controller.countryNewAddress.text.trim(),
                              streetDifferentAddress:
                                  controller.streetDifferentAddress.text.trim(),
                              cityDifferentAddress:
                                  controller.cityDifferentAddress.text.trim(),
                              stateDifferentAddress:
                                  controller.stateDifferentAddress.text.trim(),
                              postalCodeDifferentAddress: controller
                                  .pinCodeDifferentAddress.text
                                  .trim(),
                              countryDifferentAddress: controller
                                  .countryDifferentAddress.text
                                  .trim(),
                            );
                          },
                    child: Obx(
                      () {
                        return placeOrderController.isCreateOrder.value == true
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                      color: ColorResources
                                          .bottomSheetContainerColor),
                                ),
                              )
                            : Text(
                                LocalStrings.continuePlaceOrder.toUpperCase(),
                                style: boldMediumLarge.copyWith(
                                  color: ColorResources.whiteColor,
                                ),
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.space50),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      LocalStrings.orderSummary,
                      style:
                          boldMediumLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space30),
                  controller.isGetCart == true
                      ? shimmerCartData()
                      : ListView.builder(
                          itemCount:
                              controller.getCartData?.cart?.quantity?.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: size.width * 0.27,
                                      height: size.height * 0.13,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.checkBoxRadius),
                                        border: Border.all(
                                            color: ColorResources
                                                .inactiveTabColor),
                                        color: ColorResources.whiteColor,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.checkBoxRadius),
                                        child: CachedCommonImage(
                                          networkImageUrl: controller
                                              .getCartData
                                              ?.cart
                                              ?.quantity![index]
                                              .productId
                                              ?.image01,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space20),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                    .getCartData
                                                    ?.cart
                                                    ?.quantity![index]
                                                    .productId
                                                    ?.title ??
                                                "",
                                            overflow: TextOverflow.ellipsis,
                                            style: semiBoldLarge.copyWith(),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space5),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: LocalStrings.sku,
                                                  style: boldLarge.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorResources
                                                          .buttonColorDark),
                                                ),
                                                TextSpan(
                                                  text:
                                                      " ${controller.getCartData?.cart?.quantity![index].productId?.id}",
                                                  style:
                                                      mediumDefault.copyWith(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space5),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: LocalStrings.quantity,
                                                  style: boldLarge.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorResources
                                                          .buttonColorDark),
                                                ),
                                                TextSpan(
                                                  text:
                                                      " ${controller.getCartData?.cart?.quantity![index].quantity?.round()}",
                                                  style: mediumLarge.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorResources
                                                          .buttonColorDark),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space5),
                                          Text(
                                            "₹${controller.getCartData?.cart?.quantity![index].totalPriceOfProduct?.round()}",
                                            style: boldLarge.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: ColorResources
                                                    .buttonColorDark),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: Dimensions.space30),
                  const Divider(),
                  const SizedBox(height: Dimensions.space20),
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
                            "₹ ${controller.getDisplayTotalPrice().round()}",
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
                  const SizedBox(height: Dimensions.space20),
                  const Divider(),
                  const SizedBox(height: Dimensions.space2),
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
                        "₹ ${controller.getDisplayTotalPrice().round()}",
                        style: mediumLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space20),
                  Center(
                    child: Text(
                      LocalStrings.needHelp2,
                      style: mediumLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.offerColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space15),
                  Center(
                    child: Text(
                      LocalStrings.weAreAvailable,
                      textAlign: TextAlign.center,
                      style: mediumDefault.copyWith(),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: ColorResources.buttonColor,
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
                          color: ColorResources.buttonColor,
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
                          color: ColorResources.buttonColor,
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
                  const SizedBox(height: Dimensions.space25),
                  const Divider(),
                  const SizedBox(height: Dimensions.space60),
                  Column(
                    children: [
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
                      Text(
                        LocalStrings.contactUsAt,
                        style: mediumLarge.copyWith(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  addAddressDialogBox(
      {String? selectedAddressType, PlaceOrderController? controller}) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: ColorResources.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocalStrings.addANewAddress,
                  style: boldMediumLarge,
                ),
                const SizedBox(height: Dimensions.space10),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller?.firstNameNewAddress,
                        hintText: LocalStrings.firstName,
                        hintTexStyle: mediumDefault,
                        fillColor: ColorResources.whiteColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.space10),
                    Expanded(
                      child: CommonTextField(
                        controller: controller?.lastNameNewAddress,
                        hintText: LocalStrings.lastName,
                        hintTexStyle: mediumDefault,
                        fillColor: ColorResources.whiteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.space10),
                CommonTextField(
                  controller: controller?.streetNewAddress,
                  hintText: LocalStrings.streetHouseNumber,
                  hintTexStyle: mediumDefault,
                  fillColor: ColorResources.whiteColor,
                ),
                const SizedBox(height: Dimensions.space10),
                CommonTextField(
                  controller: controller?.additionalInformationNewAddress,
                  hintText: LocalStrings.additionalInformation,
                  hintTexStyle: mediumDefault,
                  fillColor: ColorResources.whiteColor,
                ),
                const SizedBox(height: Dimensions.space10),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller?.pinCodeNewAddress,
                        hintText: LocalStrings.pinCode,
                        hintTexStyle: mediumDefault,
                        fillColor: ColorResources.whiteColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.space10),
                    Expanded(
                      child: CommonTextField(
                        controller: controller?.cityNewAddress,
                        hintText: LocalStrings.city,
                        hintTexStyle: mediumDefault,
                        fillColor: ColorResources.whiteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.space10),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller?.stateNewAddress,
                        hintText: LocalStrings.state,
                        hintTexStyle: mediumDefault,
                        fillColor: ColorResources.whiteColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.space10),
                    Expanded(
                      child: CommonTextField(
                        controller: controller?.countryNewAddress,
                        hintText: LocalStrings.country,
                        hintTexStyle: mediumDefault,
                        fillColor: ColorResources.whiteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.space10),
                CommonTextField(
                  controller: controller?.mobileNumberNewAddress,
                  hintText: LocalStrings.mobileNumber,
                  hintTexStyle: mediumDefault,
                  fillColor: ColorResources.whiteColor,
                ),
                const SizedBox(height: Dimensions.space10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    fillColor: ColorResources.whiteColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: ColorResources.borderColor,
                        width: 1,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  hint: Text(
                    LocalStrings.selectAddressType,
                    style: const TextStyle(
                      color: ColorResources.borderColor,
                    ),
                  ),
                  style: const TextStyle(
                    color: ColorResources.blackColor,
                  ),
                  value: selectedAddressType,
                  items: ['Home', 'Work', 'Other'].map(
                    (String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(
                          type,
                          style: const TextStyle(
                            color: ColorResources.blackColor,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    selectedAddressType = value;
                  },
                ),
                const SizedBox(height: Dimensions.space10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller?.clearAllNewAddressField();
                        Get.back();
                      },
                      child: Text(LocalStrings.cancel),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(LocalStrings.save),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Shimmer effect show when server through data fetch to cart data time
  shimmerCartData() {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Shimmer.fromColors(
                  baseColor: ColorResources.baseColor,
                  highlightColor: ColorResources.highlightColor,
                  child: Container(
                    width: size.width * 0.27,
                    height: size.height * 0.13,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.checkBoxRadius),
                      border:
                          Border.all(color: ColorResources.inactiveTabColor),
                      color: ColorResources.whiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.space20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          width: size.width * 0.45,
                          height: size.height * 0.012,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.checkBoxRadius),
                            border: Border.all(
                                color: ColorResources.inactiveTabColor),
                            color: ColorResources.whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          width: size.width * 0.30,
                          height: size.height * 0.010,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.checkBoxRadius),
                            border: Border.all(
                                color: ColorResources.inactiveTabColor),
                            color: ColorResources.whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          width: size.width * 0.25,
                          height: size.height * 0.010,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.checkBoxRadius),
                            border: Border.all(
                                color: ColorResources.inactiveTabColor),
                            color: ColorResources.whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          width: size.width * 0.20,
                          height: size.height * 0.010,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.checkBoxRadius),
                            border: Border.all(
                                color: ColorResources.inactiveTabColor),
                            color: ColorResources.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildRadioTile(
  Size size,
  String title,
  bool isSelected,
  VoidCallback onTap,
) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: const Color(0xfff6f4f9),
    child: Theme(
      data: ThemeData(splashColor: Colors.transparent),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          title,
          style: boldLarge.copyWith(
            color: ColorResources.buttonColor,
          ),
        ),
        trailing: Transform.scale(
          scale: 1.50,
          child: Radio<bool>(
            value: isSelected,
            groupValue: isSelected ? true : null,
            activeColor: ColorResources.buttonColor,
            onChanged: (value) => onTap(),
          ),
        ),
        onTap: onTap,
      ),
    ),
  );
}
